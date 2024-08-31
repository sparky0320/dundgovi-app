// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/agent/agent_controller.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:location/location.dart';
import 'package:move_to_earn/core/connection.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/homepage/my_home_page_controller.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_list.dart';
import 'package:move_to_earn/ui/views/home/modalbottoms.dart';
import 'package:move_to_earn/ui/views/home/my_home_page.dart';
import 'package:move_to_earn/ui/views/miniapp/mini_app.dart';
import 'package:move_to_earn/ui/views/profile/profile_screen.dart';
import 'package:move_to_earn/ui/views/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../ui/views/coupon/coupon.dart';

class MainPageTCRCtrl extends GetxController {
  final AgentController agentController = Get.put(AgentController());
  MyHomePageCtrl controller = Get.put(MyHomePageCtrl());
  int selectedIndex = 1;
  FocusNode inputNode = FocusNode();
  bool loading = false;
  RxInt point = 0.obs;
  TextEditingController goalCtrl = TextEditingController();
  NetworkUtil _netUtil = NetworkUtil();
  RxString stepgoal = '0'.obs;
  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  RxNum setGoal = RxNum(10000);

  Future<void> locationService() async {
    _serviceEnabled = await location.serviceEnabled();
    print('_serviceEnabled  ---- $_serviceEnabled');
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    print('_permissionGranted  ----${_permissionGranted}');
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    if (_permissionGranted == PermissionStatus.granted) {
      _locationData = await location.getLocation();
      print('_locationData  ---- ${_locationData?.latitude}');
      print('_locationData  ---- ${_locationData?.longitude}');

      try {
        var response = await _netUtil.post('/api/register-location-log', {
          "user_id": appController.user.value.id,
          "latitude": _locationData?.latitude,
          "longitude": _locationData?.longitude,
        });
      } catch (e) {
        FirebaseCrashlytics.instance.recordError(
          Exception(e),
          StackTrace.current, // you should pass stackTrace in here
          reason: e,
          fatal: false,
        );
      }
    }
  }

  List<Widget> pages = [
    MyHomePage(),
    CouponPage(),
    ChallangeListPage(showBack: false),
    if (pendingVersion != versionCode) MiniApp(),
    // if (miniappIsHidden == false) MiniApp(),
    ProfilePage(),
  ];

  void updateTabSelection(int index) {
    selectedIndex = index;
    update();
  }

  Future checkDailyGoal(contex) async {
    // loading = true;
    if (await checkConnection()) {
      try {
        final response = await _netUtil
            .get('/api/check-daily-goal/${appController.user.value.id}');
        if (response != null && response['status'] != true) {
          // setDailyGoalDialog(contex);
          dialogGoal(contex);
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
  }

  createAndEditGoal<String>(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    print(setGoal.value);
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var uri = Uri.parse(endPoint + '/api/v1/goal/create-and-edit');
      var request = http.MultipartRequest('POST', uri)
        ..fields['user_id'] = appController.user.value.id.toString()
        ..fields['goal'] = setGoal.value.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        if (jsonResponse != null && jsonResponse['status'] == true) {
          pr.update(message: jsonResponse['msg'], type: 'success');
          await new Future.delayed(const Duration(seconds: 1));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt("daily_goal", setGoal.value as int);
          // prefs.setInt("daily_goal", int.parse(goalCtrl.text));
          pr.hide();
          appController.dailyGoal.value = setGoal.value as int;
          // appController.dailyGoal.value = int.parse(goalCtrl.text);
          Navigator.pop(context);

          Get.offAll(() => MainPage());
        } else {
          pr.update(message: jsonResponse['msg'], type: 'error');
          await new Future.delayed(const Duration(milliseconds: 1500));
          pr.hide();
        }
      } else {
        print('Failed to load data');
      }
      // var response = await _netUtil.post('/api/create-and-edit', {
      //   "user_id": appController.user.value.id,
      //   "goal": setGoal.value,
      //   // "goal": goalCtrl.text,
      // });
      // print(response);
      // if (response != null && response['status'] == true) {
      //   pr.update(message: response['msg'], type: 'success');
      //   await new Future.delayed(const Duration(seconds: 1));
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   prefs.setInt("daily_goal", setGoal.value as int);
      //   // prefs.setInt("daily_goal", int.parse(goalCtrl.text));
      //   pr.hide();
      //   appController.dailyGoal.value = setGoal.value as int;
      //   // appController.dailyGoal.value = int.parse(goalCtrl.text);
      //   Navigator.pop(context);

      //   Get.offAll(() => MainPage());
      // } else {
      //   pr.update(message: response['msg'], type: 'error');
      //   await new Future.delayed(const Duration(milliseconds: 1500));
      //   pr.hide();
      // }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }
}
