import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/app.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/controllers/firebase_remote_config.dart';
import 'package:move_to_earn/splash_app.dart';
import 'package:pedometer/pedometer.dart';
import 'package:pedometer_db/pedometer_db.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isDev') != null) {
      FireBaseRemoteConfig(prefs.getBool('isDev'));
    } else {
      FireBaseRemoteConfig(false);
    }
  });
  await [
    Permission.locationAlways,
    Permission.activityRecognition,
    Permission.notification
  ].request();

  // } else {
  //   Permission.activityRecognition.request();
  // }

  await initializeBackgroundService();

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    SplashApp(
      key: UniqueKey(),
      onInitializationComplete: (routeToJump) => runMainApp(routeToJump),
    ),
  );
}

void runMainApp(String value) {
  runApp(
    MyApp(routeToJump: value),
  );
}

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'gocare_foreground', // id
    'GO CARE FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('app_icon'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      autoStart: true,
      autoStartOnBoot: true,
      isForegroundMode: true,
      notificationChannelId: 'gocare_foreground',
      initialNotificationTitle: 'GOCARE SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  // pedometer_db package init
  final _pedometerDB = PedometerDb();
  _pedometerDB.initialize();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  late Stream<StepCount> _stepCountStream;
  // stepCount.value = await getTodaySteps();
  _stepCountStream = Pedometer.stepCountStream;

  _stepCountStream.listen(
    (StepCount event) async {
      int? currentStepCount;
      // if (Platform.isIOS) {
      //   await _pedometerDB.insertPedometerData(event);
      // } else
      if (Platform.isAndroid) {
        // await SteplogDatabase().insertData(event);
        await _pedometerDB.insertPedometerData(event);

        DateTime now = DateTime.now();
        DateTime startOfDay = DateTime(now.year, now.month, now.day);
        DateTime endOfDay =
            DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);
        int? totalRows = await _pedometerDB.getTotal(
            startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch);
        print('test100 rows:${totalRows}');
        if (totalRows != null && (totalRows > 100)) {
          await appController.deleteUnusedData(_pedometerDB);
        }
      }

      // _pedometerDB.insertPedometerData(event);
      currentStepCount = await getTodaySteps(_pedometerDB);

      //checkDateDifference();

      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          /// OPTIONAL for use custom notification
          /// the notification id must be equals with AndroidConfiguration when you call configure() method.

          flutterLocalNotificationsPlugin.show(
            888,
            'Gocare',
            "Steps: ${NumberFormat().format(currentStepCount < 0 ? 0 : currentStepCount)}",
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'gocare_foreground',
                'GOCARE FOREGROUND SERVICE',
                icon: '@drawable/app_icon',
                ongoing: true,
              ),
            ),
          );

          // if you don't using custom notification, uncomment this
          // service.setForegroundNotificationInfo(
          //   title: "GoCare",
          //   content: "Steps: ${currentStepCount}",
          // );
        }
      }
    },
  );
}

Future<int> getTodaySteps(pedometerDB) async {
  DateTime now = DateTime.now();
  DateTime startOfDay = DateTime(now.year, now.month, now.day);
  DateTime endOfDay =
      DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);
  // int endTime = DateTime.now().microsecondsSinceEpoch;
  return await pedometerDB.queryPedometerData(
      startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch);
}
