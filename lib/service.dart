import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
void callbackDispatcher() async {
  // Workmanager().executeTask((task, inputData) async {
  DateTime now = DateTime.now();
  print("Native called background task: ");
  if (now.hour == 0) {
    print('CRON');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Hive.init((await getApplicationDocumentsDirectory()).path);
    // String f = DateFormat('yyyy-MM-dd').format(now);

    try {
      StepCount abc = await Pedometer.stepCountStream.first;
      if (abc.steps > 0) {
        // var box = await Hive.openBox('system_step_log');
        prefs.setString("sync_value", now.toString());
      } else {
        prefs.setString("sync_value", "GGGGGGGGG");
      }
    } catch (e) {
      prefs.setString("sync_value", e.toString());
    }
  }

  // await box.put(DateFormat('yyyy-MM-dd').format(now), abc.steps);

  // return true;
  // });
}
