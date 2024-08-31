import 'dart:io';
import 'package:pedometer_db/model/step.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SteplogDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDB();
    return _database!;
  }

//manaih
  static Future<Database> initDB() async {
    // Get a location using getDatabasesPath
    String path = join(await getDatabasesPath(), 'pedometer_v1_db.db');

    // Open/create the database at a given path
    return openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
    );
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final Database db = await database;
    return await db.query(
      'steps',
      orderBy: 'id DESC',
    );
  }

  static Future<int> getTodayInitStepData(DateTime date) async {
    final Database db = await database;
    // DateTime now = DateTime.now();

    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay =
        DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999);

    int startTime = startOfDay.millisecondsSinceEpoch;
    int endTime = endOfDay.millisecondsSinceEpoch;

    List<Map<String, Object?>>? firstMaps = await db
        .rawQuery('SELECT * from steps where timestamp >= $startTime limit 1');
    List<Map<String, Object?>>? lastMaps = await db.rawQuery(
        'SELECT * from steps where timestamp < $endTime ORDER BY id desc limit 1');

    Step? firstStep;
    Step? lastStep;

    firstStep = firstMaps.isNotEmpty ? Step.fromMap(firstMaps.first) : null;
    lastStep = lastMaps.isNotEmpty ? Step.fromMap(lastMaps.first) : null;

    int realDataStep = 0;

    if (firstStep != null && lastStep != null) {
      if (Platform.isAndroid) {
        realDataStep = (lastStep.total ?? 0) - (firstStep.total ?? 0);
      } else {
        realDataStep = (lastStep.total ?? 0);
      }
    }
    return realDataStep;
  }

  static Future<List<Map<String, String>>> getWeeklyData() async {
    final Database db = await database;
    DateTime today = DateTime.now();
    print(today);
    List<Map<String, String>> weeklyData = [];

    //geting first day of database
    List<Map<String, Object?>>? initialMaps =
        await db.rawQuery('SELECT * from steps limit 1');
    Step initialStep = Step.fromMap(initialMaps.first);

    int differenceInDays = 7;

    differenceInDays = today
            .difference(DateTime.fromMillisecondsSinceEpoch(
                initialStep.timestamp as int))
            .inDays +
        1;

    for (int i = 0; i < differenceInDays; i++) {
      DateTime startOfDay = DateTime(
        today.year,
        today.month,
        today.day - i,
      ); // This sets the time to 00:00:00

      DateTime endOfDay = DateTime(startOfDay.year, startOfDay.month,
          startOfDay.day, 23, 59, 59, 999, 999);

      int startTime = startOfDay.millisecondsSinceEpoch;
      int endTime = endOfDay.millisecondsSinceEpoch;

      List<Map<String, Object?>>? firstMaps = await db.rawQuery(
          'SELECT * from steps where timestamp >= $startTime limit 1');
      List<Map<String, Object?>>? lastMaps = await db.rawQuery(
          'SELECT * from steps where timestamp < $endTime ORDER BY id desc limit 1');

      Step? firstStep;
      Step? lastStep;

      firstStep = firstMaps.isNotEmpty ? Step.fromMap(firstMaps.first) : null;
      lastStep = lastMaps.isNotEmpty ? Step.fromMap(lastMaps.first) : null;

      int realDataStep = 0;

      if (firstStep != null && lastStep != null) {
        if (Platform.isAndroid) {
          realDataStep = (lastStep.total ?? 0) - (firstStep.total ?? 0);
        } else {
          realDataStep = (lastStep.total ?? 0);
        }
      }
      weeklyData.add({
        "step_count": realDataStep.toString(),
        "date": startOfDay.toString().substring(0, 10)
      });
    }
    return weeklyData;
  }
}
