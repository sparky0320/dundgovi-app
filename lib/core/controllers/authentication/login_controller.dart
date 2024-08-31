import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/agent/agent_controller.dart';
import '../../../ui/views/main_page.dart';
import '../../constants/values.dart';
import '../../models/user.dart';
import '../app_controller.dart';

class LoginController extends GetxController {
  // final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  final AgentController agentController = Get.put(AgentController());
  final AppController appController = Get.put(AppController());
  bool toggleEye = true;
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final List<bool> selectedLoginOptions = <bool>[true, false];

  @override
  void onInit() {
    super.onInit();
  }

  doLogin(ctx) async {
    try {
      bool isAuth = await agentController.doLogin(
        ctx,
        endPoint + '/api/v1/auth/login',
        selectedLoginOptions[0] == true ? email.text : phone.text,
        password.text,
        loginByUsername: selectedLoginOptions[0] == true ? true : false,
      );
      // print(isAuth);
      if (isAuth) {
        User user =
            new User.fromJson(jsonDecode(agentController.userData.value));
        print('agent -------');
        print(agentController.userData.value);
        appController.setUser(user);
        // appController.deleteStepLocal();
        email.clear();
        phone.clear();
        password.clear();
        Get.offAll(
          MainPage(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );
      }
    } catch (e) {
      print(e);
      FirebaseCrashlytics.instance.recordError(
        Exception(e),

        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  // ---------------------- use HTTP ------------------------------
}
