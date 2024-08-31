// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/agent/agent_controller.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user.dart';
import 'app_controller.dart';

import 'package:move_to_earn/core/connection.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();
  final AgentController _agentController = Get.put(AgentController());

  final AppController _appController = Get.find();
  NetworkUtil netUtil = Get.find();
  RxBool animate = false.obs;

  Future checkAll() async {
    //await fetchConfig();
    //await getTranslate();
  }

  Future<String> checkNextRoute() async {
    await netUtil.initNetwork(baseUrl);
    bool isAuth = await _agentController.checkAuth();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hideIntro = prefs.getBool("hideIntro");
    await Future.delayed(const Duration(microseconds: 100));

    if (isAuth) {
      User user =
          new User.fromJson(jsonDecode(_agentController.userData.value));
      _appController.setUser(user);
      registerOpenApp(user.id);
      return '/main-page';
      // Get.to(
      //   () => MainPage(),
      //   duration: const Duration(milliseconds: 500),
      //   transition: Transition.rightToLeftWithFade,
      // );
    } else if (hideIntro != null && hideIntro == true) {
      return '/welcome_screen';
      // Get.to(
      //   () => WelcomeScreen(),
      //   duration: const Duration(milliseconds: 800),
      //   transition: Transition.rightToLeftWithFade,
      // );
    } else {
      return '/';
      // Get.to(
      //   () => SelectLanguagePage(),
      //   duration: const Duration(milliseconds: 800),
      //   transition: Transition.rightToLeftWithFade,
      // );
    }
  }

  Future fetchConfig() async {
    final prefs = await SharedPreferences.getInstance();
    if (await checkConnection()) {
      print("FETCH CONFIG");
      // await FireBaseRemoteConfig();
      prefs.setInt('Connection', 1);
    } else {
      toast("Интернет холболтоо шалгана уу...",
          print: true, textColor: greenColor, bgColor: black);
      prefs.setInt('Connection', 0);
    }
  }

  Future startAnimation({bool version = true}) async {
    await netUtil.initNetwork(baseUrl);
    bool isAuth = await _agentController.checkAuth();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hideIntro = prefs.getBool("hideIntro");
    await Future.delayed(const Duration(microseconds: 500));

    await Future.delayed(const Duration(milliseconds: 6000));

    // // if (isAuth) {
    //   User user =
    //       new User.fromJson(jsonDecode(_agentController.userData.value));
    //   _appController.setUser(user);
    //   registerOpenApp(user.id);
    //   Get.to(
    //     () => MainPage(),
    //     duration: const Duration(milliseconds: 500),
    //     transition: Transition.rightToLeftWithFade,
    //   );
    // } else if (hideIntro != null && hideIntro == true) {
    //   Get.to(
    //     () => WelcomeScreen(),
    //     duration: const Duration(milliseconds: 800),
    //     transition: Transition.rightToLeftWithFade,
    //   );
    // } else {
    //   Get.to(
    //     () => SelectLanguagePage(),
    //     duration: const Duration(milliseconds: 800),
    //     transition: Transition.rightToLeftWithFade,
    //   );
    // }
  }

  void needUpdate() {
    var androilink = 'wasdasd';
    var ioslink = 'ioslink';
    if (Platform.isAndroid) {
      applink = androilink;
    } else {
      applink = ioslink;
    }
    print(applink);
  }

  void _showDialog(bool isForce, String msg, String link) {
    Get.dialog(
        AlertDialog(
          title: Text("Шинэ хувилбар"),
          content: Text(msg),
          actions: <Widget>[
            isForce
                ? Container()
                : MaterialButton(
                    child: Text(
                      "Алгасах",
                      style: TextStyle(color: Color(0xff565656)),
                    ),
                    onPressed: () async {
                      // bool isAuth = await _agentController.checkAuth();
                      // await _setInitialScreen(isAuth);
                      startAnimation(version: false);
                    },
                  ),
            MaterialButton(
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "Шинэчлэх",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                if (Platform.isAndroid) {
                  this._launchWeb(link);
                } else {
                  this._launchWeb(link);
                }
              },
            ),
          ],
        ),
        barrierDismissible: false);
  }

  Future<void> _launchWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future registerOpenApp(userId) async {
    try {
      final response = await netUtil.get('/api/register-open-app/$userId');
      debugPrint('open app register response -----$response');
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
