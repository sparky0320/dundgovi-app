import 'dart:async';
import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/controllers/input_number_ctrl.dart';
import 'package:move_to_earn/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ui/views/signup/info_screen.dart';
import '../../../utils/shake_animation.dart';

class VerifyController extends GetxController {
  final GlobalKey<FormState> verifyFormKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String errorMsg = '';
  TextEditingController verCode = new TextEditingController();
  InputNumberController inputNumberController =
      Get.put(InputNumberController());
  final pinputFocusNode = FocusNode();
  final shakeKey = GlobalKey<ShakeWidgetState>();
  NetworkUtil _netUtil = NetworkUtil();
  bool isFail = false;

  @override
  void onInit() {
    super.onInit();
  }

  resendEmail<String>(BuildContext context, email) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response =
          await _netUtil.post('/api/auth/resend-mail', {"email": email});
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await new Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
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

  doVerify<String>(BuildContext context, email) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/verify-mail', {
        "email": email,
        "verify_code": verCode.text,
      });
      print('verify ---- response -----$response');
      if (response != null && response['status'] == true) {
        isFail = false;
        update();
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.to(
          () => InfoScreen(
            email: email,
          ),
          // () => EnterInfoPage(
          //   email: email,
          // ),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );

        verCode.clear();
        inputNumberController.eraseAll();
        return true;
      } else {
        errorMsg = response['msg'];
        isFail = true;
        verCode.clear();
        inputNumberController.eraseAll();
        update();
        pr.hide();
        shakeKey.currentState?.shake();
        return false;
      }
    } catch (e) {
      errorMsg = e.toString();
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  changePhoneNumber<String>(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    print('change phone number -----$phoneNumber');
    try {
      var response = await _netUtil.post('/api/auth/change/phone',
          {"phone": phoneNumber, "id": appController.user.value.id});
      if (response != null && response['status'] == true) {
        isFail = false;
        update();
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        SharedPreferences? _prefs = await SharedPreferences.getInstance();
        _prefs.setString("user", jsonEncode(response['data']));
        _prefs.reload();
        User user = new User.fromJson(response['data']);
        appController.setUser(user);
        appController.user.value = user;
        appController.update();
        // Navigator.pop(context);
      } else {
        errorMsg = response['msg'];
        isFail = true;
        update();
        pr.hide();
        shakeKey.currentState?.shake();
      }
    } catch (e) {
      errorMsg = e.toString();
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  setEmail(email) {
    print('user email -----$email');
    email = email;
    update();
  }

  // Use ----------------------------- http ---------------------------

  // resendEmail(BuildContext context, email) async {
  //   ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   await Future.delayed(Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();

  //   String url = 'http://10.0.2.2:8000/api/auth/resend-mail';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       'email': email,
  //     });

  //     if (responseFirst.statusCode == 200) {
  //       var response = jsonDecode(responseFirst.body);

  //       if (response != null && response['status'] == true) {
  //         pr.update(message: response['msg'], type: 'success');
  //         await new Future.delayed(const Duration(seconds: 1));
  //         pr.hide();
  //       } else {
  //         pr.update(message: response['msg'], type: 'error');
  //         await new Future.delayed(const Duration(milliseconds: 1500));
  //         pr.hide();
  //       }
  //     } else {
  //       return Future.error("Serve error");
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // doVerify(BuildContext context, email) async {
  //   ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   await Future.delayed(Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();

  //   String url = 'http://10.0.2.2:8000/api/auth/verify-mail';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       "email": email,
  //       "verify_code": verCode.text,
  //     });
  //     if (responseFirst.statusCode == 200) {
  //       var response = jsonDecode(responseFirst.body);

  //       if (response != null && response['status'] == true) {
  //         isFail = false;
  //         update();
  //         pr.update(message: response['msg'], type: 'success');
  //         await new Future.delayed(const Duration(seconds: 1));
  //         pr.hide();
  //         Get.to(
  //           () => EnterInfoPage(email: email),
  //           duration: const Duration(milliseconds: 500),
  //           transition: Transition.rightToLeftWithFade,
  //         );
  //         verCode.clear();
  //         inputNumberController.eraseAll();
  //         return true;
  //       } else {
  //         errorMsg = response['msg'];
  //         isFail = true;
  //         verCode.clear();
  //         inputNumberController.eraseAll();
  //         update();
  //         pr.hide();
  //         shakeKey.currentState?.shake();
  //         return false;
  //       }
  //     } else {
  //       return Future.error("Serve error");
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
}
