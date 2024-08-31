import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';
import '../model/step.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'steps';

class StepProvider {
  Database? db;
  // Stream<StepCount>? _stepCountStream;

  Future initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/pedometer_v1_db.db";
    db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: (Database db, int version) => _createDatabase(db, version),
      // onUpgrade: (Database db, int oldVersion, int newVersion) =>
      //     _onUpgrade(db, oldVersion, newVersion),
    );
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS steps (
      id INTEGER PRIMARY KEY, 
      total INTEGER NOT NULL,
      last INTEGER NOT NULL,
      plus INTEGER NOT NULL,
      credit INTEGER,
      timestamp INTEGER NOT NULL
    )
  ''');

    //create index
    await db.execute('''
    CREATE INDEX idx_timestamp ON steps (timestamp ASC)
    ''');
  }

  // Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (kDebugMode) {
  //     print("oldVersion : $oldVersion");
  //     print("newVersion : $newVersion");
  //   }

  //   if (oldVersion < 2) {
  //     await db.execute('''ALTER TABLE steps ADD COLUMN flag INTEGER''');
  //   }
  // }

  Future<int?> insertData(StepCount event) async {
    Step? lastStep = await getLastStep();

    int last = event.steps;
    int plus = lastStep?.plus ?? 0;
    int total = last;
    int timestamp = event.timeStamp.millisecondsSinceEpoch;

    //If the application is not launched for the first time
    if (lastStep != null) {
      if (Platform.isAndroid) {
        //android
        //If reboot occurs, initialization must be done without knowing the exact step value at the time of reboot.
        if ((lastStep.last ?? 0) > event.steps && event.steps < 100) {
          // delta_steps = event.steps;
          // steps = (lastStep.steps ?? 0) + event.steps;

          // starts from 0
          total = lastStep.total ?? 0;
          plus = lastStep.total ?? 0; //더해야 할 값 재조정
        } else {
          //If it continues to accumulate without rebooting
          total = last + plus;
          if (total < 0) {
            DateTime now = DateTime.now();
            DateTime startOfDay = DateTime(now.year, now.month, now.day);
            DateTime endOfDay =
                DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);
            deleteTodayRows(startOfDay.millisecondsSinceEpoch,
                endOfDay.millisecondsSinceEpoch);
          }
        }
      }
    } //end if

    debugPrint(
        "** insertData last: ${last}, plus: ${plus}, total: ${total}, steps: ${event.steps}, timestamp: ${timestamp}");

    return await db?.insert(
      tableName, // table name
      {
        'total': total,
        'last': last,
        'timestamp': timestamp,
        'plus': plus,
      }, // new post row data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int?> insertDataIOS(int event) async {
    Step? lastStep = await getLastStep();

    int last = event;
    int plus = 0;
    int total = event;
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    //If the application is not launched for the first time
    if (lastStep != null) {
      if (lastStep.last != event) {
        return await db?.insert(
          tableName, // table name
          {
            'total': total,
            'last': last,
            'timestamp': timestamp,
            'plus': plus,
          }, // new post row data
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } //end if
    else {
      return await db?.insert(
        tableName, // table name
        {
          'total': total,
          'last': last,
          'timestamp': timestamp,
          'plus': plus,
        }, // new post row data
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return 0;
  }

  Future<int> queryPedometerData(int startTime, int endTime) async {
    //You need to import data from outside the db range one by one and combine the data.
    List<Map<String, Object?>>? firstYesterdayMaps;
    List<Map<String, Object?>>? firstMaps = await db?.rawQuery(
        'SELECT * from $tableName where timestamp >= $startTime limit 1');
    List<Map<String, Object?>>? lastMaps = await db?.rawQuery(
        'SELECT * from $tableName where timestamp < $endTime ORDER BY id desc limit 1');

    Step? firstYesterdayStep;
    Step? firstStep;
    Step? lastStep;
    bool firstNoExist =
        false; //When there is no value in the db before the query date, the value is retrieved before app installation, so it is used to retrieve the first value
    bool lastNoExist =
        false; //When the last value of the search date is not in the db, it is the same as getting the value after the current time, so it is used to retrieve the last value.

    if (firstMaps != null && firstMaps.isEmpty) {
      //Get the first data from db
      firstNoExist = true;
      firstMaps = await db?.rawQuery('SELECT * from $tableName limit 1');
    } else if (firstMaps != null && firstMaps.isNotEmpty) {
      //If today's recorded value is a little late and there is an error with other apps (about 15 levels), try reducing the error by calculating yesterday's last recorded value as the first number of steps today.
      firstYesterdayMaps = await db?.rawQuery(
          'SELECT * from $tableName where timestamp < $startTime ORDER BY id desc limit 1');
      if (firstYesterdayMaps != null && firstYesterdayMaps.isNotEmpty) {
        firstYesterdayStep = Step.fromMap(firstYesterdayMaps.first);
      }
    }

    if (firstMaps != null && firstMaps.isNotEmpty) {
      firstStep = Step.fromMap(firstMaps.first);
      if (firstYesterdayStep != null) {
        int diff =
            (firstStep.timestamp ?? 0) - (firstYesterdayStep.timestamp ?? 0);
        if (diff > 0 && diff < 3600000) {
          //If the error is within 1 hour
          firstStep =
              firstYesterdayStep; //Assume yesterday's last recorded value as today's first number of steps.
        }
      }
    }

    if (lastMaps != null && lastMaps.isEmpty) {
      //Get the last data from db
      lastNoExist = true;
      lastMaps = await db
          ?.rawQuery('SELECT * from $tableName ORDER BY id desc limit 1');
    }
    if (lastMaps != null && lastMaps.isNotEmpty) {
      lastStep = Step.fromMap(lastMaps.first);
    }

    debugPrint(
        "** lastTotal: ${lastStep?.total}, firstTotal: ${firstStep?.total}");
    //Correction of expected value search time when there is no value
    if (firstNoExist) {
      startTime = firstStep?.timestamp ?? startTime;
    }
    if (lastNoExist) {
      endTime = lastStep?.timestamp ?? endTime;
    }

    int realDataStep = (lastStep?.total ?? 0) - (firstStep?.total ?? 0);
    // int realDataDuration = (lastStep?.timestamp ?? 0) - (firstStep?.timestamp ?? 0);
    // if(realDataDuration == 0) realDataDuration = 1; //Exception handling to avoid division by 0

    // double percent = (endTime - startTime) / realDataDuration; //Converted ratio to obtain expected data
    //record steps

    debugPrint(
        "** startTime: $startTime, endTime: $endTime, diff: ${endTime - startTime}, realDataStep: ${realDataStep}, plus: ${lastStep?.plus}, last: ${lastStep?.last}");

    // return (realDataStep * percent).toInt(); //Return expected value
    return realDataStep; //return actual value
  }

  Future<Step?> getLastStep() async {
    List<Map<String, Object?>>? maps =
        await db?.rawQuery('SELECT * from $tableName ORDER BY id DESC limit 1');
    if (maps == null) return null;
    if (maps.isEmpty) return null;
    return Step.fromMap(maps.first);
  }

  Future<int?> delete(int id) async {
    return await db?.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> update(Step step) async {
    return await db?.update(tableName, step.toMap(),
        where: 'id = ?', whereArgs: [step.id]);
  }

  Future<Map<String, int>> getFirstAndLastRowIds(
      int startTime, int endTime) async {
    print('test100 calling provider');
    print('test100 ${db}');

    List<Map<String, Object?>>? firstMaps = await db?.rawQuery(
        'SELECT * from $tableName where timestamp > $startTime limit 1');
    List<Map<String, Object?>>? lastMaps = await db?.rawQuery(
        'SELECT * from $tableName where timestamp < $endTime ORDER BY id desc limit 1');

    if ((firstMaps != null && firstMaps.isEmpty) ||
        (lastMaps != null && lastMaps.isEmpty)) {
      print('test100 empty first or last id');
      throw Exception('Table is empty or unable to retrieve rows.');
    }
    print('test100 ${firstMaps?.length.toString()}');
    print('test100 ${firstMaps.toString()}');
    print('test100 ${firstMaps?.first}');
    print('test100 ${firstMaps?.first['id']}');

    return {
      'firstId': firstMaps?.first['id'] as int,
      'lastId': lastMaps?.first['id'] as int,
    };
  }

  Future<void> deleteRowsExceptFirstAndLast(int startTime, int endTime) async {
    try {
      Map<String, int> ids = await getFirstAndLastRowIds(startTime, endTime);
      int firstId = ids['firstId']!;
      int lastId = ids['lastId']!;

      print("test100 ${firstId} ---------------------------- ${lastId}");

      await db?.delete(
        tableName,
        where:
            'id NOT IN (?, ?) and timestamp >= $startTime and timestamp < $endTime',
        whereArgs: [firstId, lastId],
      );
      print(
          'test100 Rows deleted successfully, except the first and last ones.');
    } catch (e) {
      print('test100 Error: $e');
    }
  }

  Future<void> deleteTodayRows(int startTime, int endTime) async {
    try {
      await db?.delete(tableName,
          where: 'timestamp >= $startTime and timestamp < $endTime');
      print(
          'test100 All today datas deleted successfully, except the first and last ones.');
    } catch (e) {
      print('test100 Error: $e');
    }
  }

  Future<int?> getTotal(int startTime, int endTime) async {
    List<Map<String, Object?>>? maps = await db?.rawQuery(
        'SELECT * from $tableName where timestamp >= $startTime and timestamp < $endTime');
    return maps?.length;
  }

  Future close() async => db?.close();
}
