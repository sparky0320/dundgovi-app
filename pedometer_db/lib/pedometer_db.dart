import 'dart:io';
import 'package:pedometer/pedometer.dart';
import 'pedometer_db_method_channel.dart';
import 'provider/step_provider.dart';

class PedometerDb {
  final _channelPedometerDb = MethodChannelPedometerDb();
  final _stepProvider = StepProvider();

  Future<void> initialize() async {
    await _stepProvider.initDatabase();
    // await _stepProvider.initStepCountStream();
  }

  Future<int> queryPedometerData(int startTime, int endTime) async {
    // print("queryPedometerData : $stepProvider, $_channelPedometerDb");
    if (Platform.isIOS) {
      return await _channelPedometerDb.queryPedometerDataFromOS(
              startTime, endTime) ??
          0;
    }
    return await _stepProvider.queryPedometerData(startTime, endTime);
  }

  Future<int> insertPedometerData(StepCount event) async {
    return await _stepProvider.insertData(event) ?? 0;
  }

  Future<int> insertPedometerDataIOS(int event) async {
    return await _stepProvider.insertDataIOS(event) ?? 0;
  }

  Future<void> deleteDatas(int startTime, int endTime) async {
    print('test 100 : start calling delete');
    await _stepProvider.deleteRowsExceptFirstAndLast(startTime, endTime);
    // await _stepProvider.initStepCountStream();
  }

  Future<void> deleteAllDatas(int startTime, int endTime) async {
    print('test 100 : start calling delete');
    await _stepProvider.deleteRowsExceptFirstAndLast(startTime, endTime);
    // await _stepProvider.initStepCountStream();
  }

  Future<int?> getTotal(int startTime, int endTime) async {
    return await _stepProvider.getTotal(startTime, endTime);
  }
}
