// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cron/cron.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:health/health.dart';
import 'package:health_kit_reporter/health_kit_reporter.dart';
import 'package:health_kit_reporter/model/predicate.dart';
import 'package:health_kit_reporter/model/type/quantity_type.dart';
import 'package:intl/intl.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/models/badges_model.dart';
import 'package:move_to_earn/core/models/badges_user_model.dart';
import 'package:move_to_earn/core/models/banner_model.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/core/models/step_user_log.dart';
import 'package:move_to_earn/main.dart';
import 'package:move_to_earn/ui/views/profile/achievement/achievement_certificate.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pedometer/pedometer.dart';
import 'package:pedometer_db/pedometer_db.dart';
import 'package:pedometer_db/step_log_db.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/controllers.dart';
import '../constants/values.dart';
import '../models/challenge/challenge_gift.dart';
import '../models/step/step_model.dart';
import '../models/user.dart';
import 'package:apple_product_name/apple_product_name.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController {
  static AppController instance = Get.find();
  final pedometerDb = PedometerDb();

  Rx<User> user = User().obs;
  dynamic danUserInfo;
  dynamic score;
  dynamic kyc;
  dynamic kycStatus;
  String? version;
  bool fcmLoaded = false;
  bool loading = false;
  List<StepModel> stepList = [];
  List<NewStepModel> newStepList = [];
  List<NewWeekStepModel> newWeekStepList = [];
  NetworkUtil _netUtil = NetworkUtil();
  RxNum point = RxNum(0);
  RxBool stepLoading = false.obs;
  RxInt stepCount = 0.obs;
  RxInt pedometerOriginalValue = 0.obs;
  late Stream<StepCount> _stepCountStream;
  RxBool hasStepPermission = false.obs;
  bool pointLoading = false;
  List<dynamic> scoreLogs = [];
  RxNum systemStep = RxNum(0);
  final String tableName = 'steps';
  var cron = new Cron();

  // init data
  List<ChallengeGift> gifts = [];
  RxList<dynamic> ads = [].obs;
  RxList<ChallengeModel> activeChallenge = <ChallengeModel>[].obs;
  RxList<BannerModel> bannerList = <BannerModel>[].obs;
  RxList<BadgesModel> badgesList = <BadgesModel>[].obs;
  RxList<UserStepLog> userStepLog = <UserStepLog>[].obs;
  RxList<BadgesUserModel> badgeUserList = <BadgesUserModel>[].obs;
  RxList<BannerModel> smallBannerList = <BannerModel>[].obs;
  RxInt dailyGoal = 0.obs;
  RxString isDarkhan = "null".obs;
  RxString totalPoint = "0".obs;
  RxInt healthStep = 0.obs;
  RxInt realIosStep = 0.obs;
  int yesterdayStep = 0;
  bool isAddedStep = false;
  int addedStepData = 0;

  Timer? timer;

  InterstitialAd? _interstitialAd;
  AdRequest request = AdRequest(
    nonPersonalizedAds: true,
  );

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    cron.close();
  }

  setUser(User? userData) {
    if (userData != null) {
      user.value = userData;
    } else {
      user.value = User();
    }
    update();
  }

  // save login log
  Future saveLoginLog() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? device;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = "Android " +
          androidInfo.version.sdkInt.toString() +
          " " +
          "name: ${androidInfo.model}";
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      final info = await DeviceInfoPlugin().iosInfo;
      device = iosInfo.systemName +
          " " +
          iosInfo.systemVersion +
          " " +
          "name: ${info.utsname.productName}";
    }

    try {
      final response = await _netUtil.post(baseUrl + '/api/login-log', {
        'user_id': appController.user.value.id,
        'date': DateTime.now().toIso8601String(),
        'v_code': versionCode,
        'device': device,
      });
      print("loooooooog ${response}");
    } catch (e) {
      print(e);
    }
  }

  // step count and save count functions
  Future<void> initPlatformState() async {
    pedometerDb.initialize();

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  //alhalt tooloh
  void onStepCount(StepCount event) async {
    // stepCount.value = await getTodaySteps(pedometerLocalDb);

    await SteplogDatabase.getTodayInitStepData(DateTime.now()).then((value) {
      if (value > 0) {
        stepCount.value = value;
      }
    });
  }

  //with pedometer error
  void onStepCountError(error) {
    print('onStepCountError: $error');
  }

  Future<void> hasHealthPermission() async {
    try {
      bool stepsPermission =
          await Health().hasPermissions([HealthDataType.STEPS]) ?? false;
      if (!stepsPermission) {
        stepsPermission = await Health().requestAuthorization(
          [HealthDataType.STEPS],
          permissions: [HealthDataAccess.READ],
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int?> getHealthData() async {
    // health values
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day);

    final predicate = Predicate(
      midnight,
      now,
    );

    int? steps;
    steps = await Health().getTotalStepsInInterval(midnight, now);

    // appController.yesterdayStep = (await Health()
    //     .getTotalStepsInInterval(startOfYesterday, endOfYesterday))!;

    int addedStepData = 0;

    try {
      final samples = await HealthKitReporter.sampleQuery(
          QuantityType.stepCount.identifier, predicate);

      // print('samples: ${samples.map((e) => e.map).toList()}');
      for (var lastData in samples) {
        if (lastData.map["harmonized"]["metadata"] != null) {
          appController.isAddedStep = true;
          addedStepData +=
              int.parse(lastData.map["harmonized"]["value"].toString());
        }
      }

      appController.addedStepData = addedStepData;
    } catch (e) {
      print(e);
    }

    return steps;
  }

  Future<int?> getYesterdayStepsIos() async {
    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year, now.month, now.day - 1);
    DateTime midnight =
        DateTime(now.year, now.month, now.day - 1, 23, 59, 59, 999, 999);

    final predicate = Predicate(
      start,
      midnight,
    );

    int yesterdayStep = 0;

    int? steps = await Health().getTotalStepsInInterval(start, midnight);

    int _addedStepData = 0;

    try {
      final samples = await HealthKitReporter.sampleQuery(
          QuantityType.stepCount.identifier, predicate);

      // print('samples: ${samples.map((e) => e.map).toList()}');
      for (var lastData in samples) {
        if (lastData.map["harmonized"]["metadata"] != null) {
          _addedStepData +=
              int.parse(lastData.map["harmonized"]["value"].toString());
        }
      }
      yesterdayStep = steps! - _addedStepData;

      return yesterdayStep;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<int?> getDateStepsIos(DateTime date) async {
    DateTime now = date;
    DateTime start = DateTime(now.year, now.month, now.day);
    DateTime midnight =
        DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);

    final predicate = Predicate(
      start,
      midnight,
    );

    await Health().requestAuthorization([
      HealthDataType.STEPS,
    ]);

    int yesterdayStep = 0;

    int? steps = await Health().getTotalStepsInInterval(start, midnight);

    print(steps);

    int _addedStepData = 0;

    try {
      final samples = await HealthKitReporter.sampleQuery(
          QuantityType.stepCount.identifier, predicate);

      // print('samples: ${samples.map((e) => e.map).toList()}');
      for (var lastData in samples) {
        if (lastData.map["harmonized"]["metadata"] != null) {
          _addedStepData +=
              int.parse(lastData.map["harmonized"]["value"].toString());
        }
      }
      yesterdayStep = steps! - _addedStepData;

      return yesterdayStep;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<void> refreshStepDataIos(db) async {
    Permission.activityRecognition.request();

    await hasHealthPermission();
    healthStep.value = await getHealthData() ?? 0;

    timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      await hasHealthPermission();
      healthStep.value = await getHealthData() ?? 0;
      realIosStep.value = healthStep.value - addedStepData;

      // // await SteplogDatabase().insertData(event);
      // await db.insertPedometerDataIOS(realIosStep.value);
    });
  }

  void dispose() {
    super.dispose();
  }

  // Get step function API
  Future<bool> getStep({bool reset = false, int page = 0}) async {
    loading = true;
    bool end = false;
    if (reset) {
      stepList = [];
    }
    update();
    try {
      final response = await _netUtil.post(baseUrl + '/api/step/history', {
        'user_id': appController.user.value.id,
        'user_gender': appController.user.value.gender,
        'user_weight': appController.user.value.weight,
        'user_height': appController.user.value.height,
        'user_step_length':
            (int.parse(appController.user.value.height!) * 0.4).toString(),
        "page": page,
      });
      if (response != null &&
          response['status'] == true &&
          response['data'] != null) {
        loading = false;
        if (response['data']['next_page_url'] == null) {
          end = true;
        }
        if (response['data']['data'] != null) {
          for (var item in response['data']['data']) {
            stepList.add(StepModel.fromJson(item));
          }
        }
      }
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }

    loading = false;

    update();
    return end;
  }

  Future<bool> getNewStepHistory({bool reset = false, int page = 0}) async {
    loading = true;
    bool end = false;
    if (reset) {
      newStepList = [];
    }
    update();
    try {
      var uri = Uri.parse(endPoint + '/api/v1/step/history/monthly');
      var request = http.MultipartRequest('POST', uri)
        ..fields['user_id'] = appController.user.value.id.toString()
        ..fields['user_gender'] = appController.user.value.gender ?? 'm'
        ..fields['user_weight'] = appController.user.value.weight.toString()
        ..fields['user_height'] = appController.user.value.height.toString()
        ..fields['user_step_length'] =
            (appController.user.value.height.toInt() * 0.4).toString()
        ..fields['page'] = page.toString();

      var response = await request.send();

      print(response);

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        if (jsonResponse != null &&
            jsonResponse['status'] == true &&
            jsonResponse['data'] != null) {
          loading = false;

          if (jsonResponse['data'] != null) {
            for (var item in jsonResponse['data']) {
              newStepList.add(NewStepModel.fromJson(item));
            }
          }
        }
        // handle your response data here
      } else {
        print('Failed to load data');
      }
      // final response =
      //     await _netUtil.post(baseUrl + '/api/step/history-montly', {
      //   'user_id': appController.user.value.id,
      //   'user_gender': appController.user.value.gender,
      //   'user_weight': appController.user.value.weight,
      //   'user_height': appController.user.value.height,
      //   'user_step_length': (int.parse(appController.user.value.height!) * 0.4),
      //   "page": page,
      // });
      // if (response != null &&
      //     response['status'] == true &&
      //     response['data'] != null) {
      //   loading = false;

      //   if (response['data'] != null) {
      //     for (var item in response['data']) {
      //       newStepList.add(NewStepModel.fromJson(item));
      //     }
      //   }
      // }
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }

    loading = false;

    update();
    return end;
  }

  Future<bool> getWeekStepHistory({bool reset = false, int page = 0}) async {
    loading = true;
    bool end = false;
    if (reset) {
      newWeekStepList = [];
    }
    update();
    print(appController.user.value.id);
    try {
      var uri = Uri.parse(endPoint + '/api/v1/step/history/weekly');
      var request = http.MultipartRequest('POST', uri)
        ..fields['user_id'] = appController.user.value.id.toString()
        ..fields['user_gender'] = appController.user.value.gender ?? 'm'
        ..fields['user_weight'] = appController.user.value.weight.toString()
        ..fields['user_height'] = appController.user.value.height.toString()
        ..fields['user_step_length'] =
            (appController.user.value.height.toInt() * 0.4).toString()
        ..fields['page'] = page.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        if (jsonResponse != null &&
            jsonResponse['status'] == true &&
            jsonResponse['data'] != null) {
          loading = false;

          if (jsonResponse['data'] != null) {
            for (var item in jsonResponse['data']) {
              newWeekStepList.add(NewWeekStepModel.fromJson(item));
            }
          }
        }
        // handle your response data here
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }

    loading = false;

    update();
    return end;
  }

  // Future<bool> getWeekStepHistory({bool reset = false, int page = 0}) async {
  //   loading = true;
  //   bool end = false;
  //   if (reset) {
  //     newWeekStepList = [];
  //   }
  //   update();
  //   print(appController.user.value.id);
  //   try {
  //     final response = await _netUtil
  //         .post('http://192.168.1.63:3000/api/v1/step/history/weekly', {
  //       'user_id': appController.user.value.id,
  //       'user_gender': appController.user.value.gender,
  //       'user_weight': appController.user.value.weight,
  //       'user_height': appController.user.value.height,
  //       'user_step_length': (int.parse(appController.user.value.height!) * 0.4),
  //       "page": page,
  //     });
  //     print(response['data']);
  //     // if (response != null &&
  //     //     response['status'] == true &&
  //     //     response['data'] != null) {
  //     //   loading = false;

  //     //   if (response['data'] != null) {
  //     //     for (var item in response['data']) {
  //     //       newWeekStepList.add(NewWeekStepModel.fromJson(item));
  //     //     }
  //     //   }
  //     // }
  //   } catch (e) {
  //     FirebaseCrashlytics.instance.recordError(
  //       Exception(e),
  //       StackTrace.current, // you should pass stackTrace in here
  //       reason: e,
  //       fatal: false,
  //     );
  //   }

  //   loading = false;

  //   update();
  //   return end;
  // }

  // Get point function
  Future getPoint() async {
    pointLoading = true;
    //point.value = 0;
    try {
      final response = await _netUtil.post(
          baseUrl + '/api/getPoint', {'user_id': appController.user.value.id});
      print('getPoint response ------$response');
      if (response != null && response['status'] == true) {
        if (response['data'] != null && response['data'] is String) {
          point.value = num.parse(response['data']);
        }
      }

      pointLoading = false;
      update();
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
      pointLoading = false;
      update();
    }
  }

  bool isAuth() {
    if (appController.user.value.id != null) {
      return true;
    }
    return false;
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
  }

  Future<void> resetUserInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // appController.setUser(user);
    await _prefs.setString(
        "user", jsonEncode(appController.user.value.toJson()));
  }

  Future<bool> isDateDifferent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDate = prefs.getString('sendStepDate');

    // Check if savedDate is null or if it is different from the current date
    if (DateTime.parse(selectedDate!).day != DateTime.now().day) {
      print("--------------------------resetteeee");

      return true; // Date is different or null
    } else {
      return false; // Date is the same
    }
  }

  // check days between start and end days
  Future<void> checkBeforeDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDate = prefs.getString('sendStepDate');
    String currentdate = DateTime.now().toIso8601String();

    var startDay = DateTime.parse(selectedDate!);
    var endDay = DateTime.parse(currentdate);

    var days = getDays(start: startDay, end: endDay);

    print(days);

    for (var day in days) {
      if (Platform.isIOS) {
        sendBeforeDateIOSStep(day);
      } else {
        sendBeforeDateandroidStep(day);
      }
    }
  }

  Future<void> stepsLastMoth() async {
    List lastMonth = [];

    var startDay = DateTime.now();
    var endDay = DateTime(startDay.year, startDay.month - 1, startDay.day);

    var days = getDays(start: endDay, end: startDay);

    int? step;

    for (var day in days) {
      if (Platform.isIOS) {
        // sendBeforeDateIOSStep(day);
        step = await getDateStepsIos(day);
        String formattedDate = DateFormat('yyyy-MM-dd').format(day);
        dynamic dayDict = {
          "date": formattedDate,
          "step": step,
        };

        lastMonth.add(dayDict);
        print(lastMonth);
      } else {
        // sendBeforeDateandroidStep(day);
        step = await SteplogDatabase.getTodayInitStepData(day);
        String formattedDate = DateFormat('yyyy-MM-dd').format(day);
        dynamic dayDict = {
          "date": formattedDate,
          "step": step,
        };

        lastMonth.add(dayDict);
        print(lastMonth);
      }
    }

    // end ee api duudaad boloo
  }

  List<DateTime> getDays({required DateTime start, required DateTime end}) {
    final days = end.difference(start).inDays;

    return [for (int i = 0; i < days; i++) start.add(Duration(days: i))];
  }

  // Future sendStepAndroid() async {
  //   DateTime now = DateTime.now();
  //   DateTime dayBefore = now.subtract(Duration(days: 1));
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int saveStep = await SteplogDatabase.getTodayInitStepData(dayBefore);

  //   if (saveStep > 0) {
  //     final response = await _netUtil.post(baseUrl + '/api/step/set', {
  //       'user_id': appController.user.value.id,
  //       'date': dayBefore.toString(),
  //       'step_count': saveStep,
  //       'daily_goal': dailyGoal.value,
  //     });

  //     if (response != null &&
  //         response['status'] == true &&
  //         response['data'] != null) {
  //       num? p = num.tryParse(response['data']);
  //       if (p != null && p > 0) {
  //         if (p > point.value) {
  //           Get.snackbar("Оноо нэмэгдлээ", "Таны оноо ${p}",
  //               backgroundColor: mainWhite.withOpacity(.7));
  //           // Get.dialog(Container(
  //           //   width: 320,
  //           //   height: 205,
  //           //   decoration: BoxDecoration(color: Colors.white),
  //           // ));
  //         }
  //         point.value = p;
  //       }
  //     }
  //   }

  //   await prefs.setString('sendStepDate', now.toIso8601String());
  // }

  // Future sendStepIos() async {
  //   DateTime now = DateTime.now();
  //   DateTime dayBefore = now.subtract(Duration(days: 1));
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? yesterdaySteps = await getYesterdayStepsIos();

  //   final response = await _netUtil.post(baseUrl + '/api/step/set', {
  //     'user_id': appController.user.value.id,
  //     'date': dayBefore.toString(),
  //     'step_count': yesterdaySteps,
  //     'daily_goal': dailyGoal.value,
  //   });
  //   if (response != null &&
  //       response['status'] == true &&
  //       response['data'] != null) {
  //     num? p = num.tryParse(response['data']);
  //     if (p != null && p > 0) {
  //       if (p > point.value) {
  //         Get.snackbar("Оноо нэмэгдлээ", "Таны оноо ${p}",
  //             backgroundColor: mainWhite.withOpacity(.7));
  //       }
  //       point.value = p;
  //     }
  //   }

  //   await prefs.setString('sendStepDate', now.toIso8601String());
  // }

  Future todaySendStepAndroid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      DateTime now = DateTime.now();

      int saveStep = await SteplogDatabase.getTodayInitStepData(now);

      final prefs = await SharedPreferences.getInstance();

      int lastStep = 0;

      if (prefs.getInt("last_step") != null) {
        lastStep = prefs.getInt("last_step")!;
      }

      if (await isDateDifferent()) {
        lastStep = 0;
      }

      if (lastStep == 0 || (saveStep - lastStep) > 999) {
        final response = await _netUtil.post(
          baseUrl + '/api/step-v1/set',
          {
            'user_id': appController.user.value.id,
            'date': now.toString(),
            'step_count': saveStep,
            'daily_goal': dailyGoal.value,
          },
        );

        if (response != null &&
            response['status'] == true &&
            response['data'] != null) {
          prefs.setInt("last_step", saveStep);
        } else {
          Get.snackbar("Алдаа гарлаа!", response["error"],
              backgroundColor: mainWhite.withOpacity(.7));
        }
      }

      await prefs.setString('sendStepDate', now.toIso8601String());
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
      await prefs.setString('sendStepDate', DateTime.now().toIso8601String());
    }
  }

  Future todaySendStepIOS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      DateTime now = DateTime.now();
      DateTime dayBefore = now.subtract(Duration(days: 1));

      int? saveStep = await getDateStepsIos(now);

      int lastStep = 0;

      if (prefs.getInt("last_step") != null) {
        lastStep = prefs.getInt("last_step")!;
      }

      if (await isDateDifferent()) {
        lastStep = 0;
      }

      if (lastStep == 0 || (saveStep! - lastStep) > 999) {
        final response = await _netUtil.post(
          baseUrl + '/api/step-v1/set',
          {
            'user_id': appController.user.value.id,
            'date': now.toString(),
            'step_count': saveStep,
            'daily_goal': dailyGoal.value,
          },
        );

        if (response != null &&
            response['status'] == true &&
            response['data'] != null) {
          prefs.setInt("last_step", saveStep!);
        } else {
          Get.snackbar("Алдаа гарлаа!", response["error"],
              backgroundColor: mainWhite.withOpacity(.7));
        }
      }
      await prefs.setString('sendStepDate', now.toIso8601String());
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
      await prefs.setString('sendStepDate', DateTime.now().toIso8601String());
    }
  }

  Future sendBeforeDateandroidStep(DateTime date) async {
    int saveStep = await SteplogDatabase.getTodayInitStepData(date);

    if (saveStep > 0) {
      final response = await _netUtil.post(baseUrl + '/api/step-prev/set', {
        'user_id': appController.user.value.id,
        'date': date.toString(),
        'step_count': saveStep,
        'daily_goal': dailyGoal.value,
      });

      if (response != null &&
          response['status'] == true &&
          response['data'] != null) {
        num? p = num.tryParse(response['data']);
        if (p != null && p > 0) {
          if (p > point.value) {
            Get.snackbar("Оноо нэмэгдлээ", "Таны оноо ${p}",
                backgroundColor: mainWhite.withOpacity(.7));
            // Get.dialog(Container(
            //   width: 320,
            //   height: 205,
            //   decoration: BoxDecoration(color: Colors.white),
            // ));
          }
          point.value = p;
        }
      }
    }
  }

  Future sendBeforeDateIOSStep(DateTime date) async {
    int? yesterdaySteps = await getDateStepsIos(date);

    print(yesterdaySteps);

    final response = await _netUtil.post(baseUrl + '/api/step-prev/set', {
      'user_id': appController.user.value.id,
      'date': date.toString(),
      'step_count': yesterdaySteps,
      'daily_goal': dailyGoal.value,
    });
    if (response != null &&
        response['status'] == true &&
        response['data'] != null) {
      num? p = num.tryParse(response['data']);
      if (p != null && p > 0) {
        if (p > point.value) {
          Get.snackbar("Оноо нэмэгдлээ", "Таны оноо ${p}",
              backgroundColor: mainWhite.withOpacity(.7));
        }
        point.value = p;
      }
    }
  }

  Future sendLastMonthIOSStep(DateTime date) async {
    int? yesterdaySteps = await getDateStepsIos(date);

    print(yesterdaySteps);

    final response = await _netUtil.post(baseUrl + '/api/step-prev/set', {
      'user_id': appController.user.value.id,
      'date': date.toString(),
      'step_count': yesterdaySteps,
      'daily_goal': dailyGoal.value,
    });
    if (response != null &&
        response['status'] == true &&
        response['data'] != null) {
      num? p = num.tryParse(response['data']);
      if (p != null && p > 0) {
        if (p > point.value) {
          Get.snackbar("Оноо нэмэгдлээ", "Таны оноо ${p}",
              backgroundColor: mainWhite.withOpacity(.7));
        }
        point.value = p;
      }
    }
  }

  // Get step function
  Future<bool> getScoreLog({bool reset = false, int page = 0}) async {
    bool end = false;
    if (reset) {
      scoreLogs = [];
    }

    final response = await _netUtil.post(baseUrl + '/api/score/log',
        {'user_id': appController.user.value.id, "page": page});
    if (response != null &&
        response['status'] == true &&
        response['data'] != null) {
      loading = false;
      if (response['data']['next_page_url'] == null) {
        end = true;
      }
      if (response['data']['data'] != null) {
        for (var item in response['data']['data']) {
          scoreLogs.add(item);
        }
      }
    }

    return end;
  }

  Future loadAd() async {
    try {
      if (_interstitialAd == null) {
        await InterstitialAd.load(
            // adUnitId: Platform.isAndroid
            //     ? 'ca-app-pub-8500838700347205/8640878169'
            //     : 'ca-app-pub-8500838700347205/8583084130',
            // adUnitId: "ca-app-pub-3940256099942544/1033173712", //test unit
            adUnitId: Platform.isAndroid
                ? "ca-app-pub-8500838700347205/8640878169"
                : "ca-app-pub-8500838700347205/8583084130",
            request: request,
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (InterstitialAd ad) {
                print('$ad loaded');
                _interstitialAd = ad;
                _interstitialAd!.setImmersiveMode(true);

                _showInterstitialAd();
              },
              onAdFailedToLoad: (LoadAdError error) {
                print('InterstitialAd failed to load: $error.');
              },
            ));
      }
    } catch (e) {}
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    try {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            print('ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
      );
      _interstitialAd!.show();
      // _interstitialAd = null;
    } catch (e) {}
  }

  Future getInitData(BuildContext context) async {
    // update();
    try {
      final response = await _netUtil.post(
          // endPoint + '/api/v1/init/get-data/${appController.user.value.id}',
          endPoint + '/api/v1/init/get-data/${appController.user.value.id}',
          "");
      // 'http://192.168.1.63:3000/api/v1/init/get-data/${appController.user.value.id}',
      // "");

      if (response == null || response is String) {
        // showTopToast("alert_internet_shalgana_uu".tr);
        // agentController.logout();
        // appController.logout();
        // appController.setUser(null);

        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return Container(
        //       height: 100,
        //       width: 100,
        //       color: Colors.white,
        //       child: OutlinedButton(
        //         style: OutlinedButton.styleFrom(
        //           shape: StadiumBorder(),
        //           side: BorderSide(width: 2, color: Colors.white),
        //         ),
        //         onPressed: () {
        //           main();
        //         },
        //         child: Text(
        //           'Дахин ачааллах',
        //           style: TextStyle(color: white),
        //         ),
        //       ),
        //     );
        //   },
        // );

        Get.defaultDialog(
            title: "alert_internet_shalgana_uu".tr,
            content: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor1,
                shape: StadiumBorder(),
                side: BorderSide(width: 2, color: Colors.white),
              ),
              onPressed: () {
                agentController.logout();
                appController.logout();
                appController.setUser(null);
                main();
              },
              child: Text(
                'Дахин ачааллах',
                style: TextStyle(color: white),
              ),
            ),
            barrierDismissible: false);
        // main();
      }

      if (response != null && response['status'] == true) {
        // loading = false;

        point.value = num.parse(response['data']['user_score'].toString());

        // is darkhan
        isDarkhan.value = response['data']['is_darkhan'].toString();

        // print(response['data']['small_banner']);

        // get banner
        for (var item in response['data']['banners']) {
          // if (item['banner_type'] == '2') {
          bannerList.add(BannerModel.fromJson(item));
          // } else {
          //   smallBannerList.add(BannerModel.fromJson(item));
          // }
        }
        if (badgesList.isEmpty) {
          for (var badge in response['data']['achievement']) {
            badgesList.add(BadgesModel.fromJson(badge));
          }
        }
        if (badgeUserList.isEmpty) {
          if (response['data']['achievement_user'] != null) {
            for (var badgeUser in response['data']['achievement_user']) {
              badgeUserList.add(BadgesUserModel.fromJson(badgeUser));
            }
          }
        }
        if (userStepLog.isEmpty) {
          for (var steplog in response['data']['user_step_log']) {
            userStepLog.add(UserStepLog.fromJson(steplog));
          }
        }
        smallBannerList
            .add(BannerModel.fromJson(response['data']['small_banner']));
        // get goal
      }

      User user = new User.fromJson(response['data']['user_data']);
      appController.setUser(user);

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      int? goal = _prefs.getInt("daily_goal");
      if (goal != null) {
        dailyGoal.value = goal;
      } else {
        dailyGoal.value = response['data']['daily_goal'];
      }

      loading = false;
      update();
    } on DioException catch (e) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      int? goal = _prefs.getInt("daily_goal");
      if (goal != null) {
        dailyGoal.value = goal;
      } else {
        dailyGoal.value = 0;
      }
      loading = false;
      update();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  getAchievementBadge(BuildContext context,
      {int? badgeId,
      String? badgeName,
      String? badgeImage,
      int? badgeKilo}) async {
    bool hasBadge = false;
    hasBadge = appController.badgeUserList
        .any((element) => element.badgeid == badgeId);
    if (hasBadge == true) {
      print("Already earned");
    } else {
      var uri = Uri.parse(endPoint + '/api/v1/achievement/post-achievement');
      var request = http.MultipartRequest('POST', uri)
        ..fields['user_id'] = appController.user.value.id.toString()
        ..fields['badge_id'] = badgeId.toString();
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        if (jsonResponse != null && jsonResponse['status'] == true) {
          // appController.getInitData(context);
          await getInitData(context);
          Get.to(AchievementCertificate(
              image: badgeImage, name: badgeName, kilo: badgeKilo));
        }
      }
    }
  }

  Future getAds() async {
    // ads = [];
    try {
      // // var uri = Uri.parse('http://192.168.1.63:3000/api/v1/ads/get-data');
      // var uri = Uri.parse(baseUrl + '/api/ads');
      // var request = http.MultipartRequest('POST', uri)
      //   ..fields['user_id'] = appController.user.value.id.toString();

      // var response = await request.send();

      // if (response.statusCode == 200) {
      //   var responseData = await response.stream.bytesToString();
      //   var jsonResponse = jsonDecode(responseData);
      //   if (jsonResponse != null && jsonResponse['status'] == true) {
      //     //   // if (response['data'] != null) {
      //     ads.value = jsonResponse["data"];
      //     //     // ads.add(response['data']);
      //     update();
      //     //     //   // }
      //   }
      // }
      final response = await _netUtil.post(
        baseUrl + '/api/ads',
        {"user_id": appController.user.value.id},
      );
      if (response != null && response['status'] == true) {
        // if (response['data'] != null) {
        ads.value = response['data'];
        // ads.add(response['data']);
        update();
        // }
      }
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  showTopToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Future<int?> deleteUnusedData(pedometerDB) async {
    try {
      pedometerDb.initialize();
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);
      // int endTime = DateTime.now().microsecondsSinceEpoch;

      var result = await pedometerDB.deleteDatas(
          startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch);
      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<int?> deleteTodayData(pedometerDB) async {
    try {
      pedometerDb.initialize();
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);
      // int endTime = DateTime.now().microsecondsSinceEpoch;

      var result = await pedometerDB.deleteAllDatas(
          startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch);
      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> checkIsTodayShowDone() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    SharedPreferences preferences = await _prefs;
    String? lastVisitDate = preferences.getString("todaydone");

    String toDayDate = DateTime.now()
        .day
        .toString(); // Here is you just get only date not Time.

    if (toDayDate == lastVisitDate) {
      // this is the user same day visit again and again
      return true;
    } else {
      // this is the user first time visit
      preferences.setString("todaydone", toDayDate);
      return false;
    }
  }

  Future<bool> checkIsTodayShowPercent50() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    SharedPreferences preferences = await _prefs;
    String? lastVisitDate = preferences.getString("today50");

    String toDayDate = DateTime.now()
        .day
        .toString(); // Here is you just get only date not Time.

    if (toDayDate == lastVisitDate) {
      // this is the user same day visit again and again
      return true;
    } else {
      // this is the user first time visit
      preferences.setString("today50", toDayDate);
      return false;
    }
  }

  Future<bool> checkIsTodayShowPercent80() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    SharedPreferences preferences = await _prefs;
    String? lastVisitDate = preferences.getString("today80");

    String toDayDate = DateTime.now()
        .day
        .toString(); // Here is you just get only date not Time.

    if (toDayDate == lastVisitDate) {
      // this is the user same day visit again and again
      return true;
    } else {
      // this is the user first time visit
      preferences.setString("today80", toDayDate);
      return false;
    }
  }
}
