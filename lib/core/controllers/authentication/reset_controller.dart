import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/controllers/input_number_ctrl.dart';
import 'package:move_to_earn/ui/views/login/new_pass.dart';
import 'package:move_to_earn/ui/views/login/reset_pass_verify.dart';
import '../../../utils/shake_animation.dart';

class ResetPasswordController extends GetxController {
  int phoneLength = 0;
  int emailLength = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final shakeKey = GlobalKey<ShakeWidgetState>();
  final GlobalKey<FormState> verifyFormKey = GlobalKey<FormState>();
  final pinputFocusNode = FocusNode();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController passwordConfirm = new TextEditingController();
  TextEditingController verCode = new TextEditingController();
  InputNumberController inputNumberController =
      Get.put(InputNumberController());
  NetworkUtil _netUtil = NetworkUtil();
  bool isFail = false;
  bool toggleEye = true;
  bool toggleEye1 = true;
  bool toggleEye2 = true;
  bool toggleEyeOld = true;
  String errorMsg = '';
  String phoneNumber = '';
  String emailAdr = '';
  changeToggleEye() {
    print('toggle eye ---$toggleEye ');
    toggleEye = !toggleEye;
    update();
  }

  changeToggleEye2() {
    toggleEye2 = !toggleEye2;
    update();
  }

  checkRegisterPhone<String>(BuildContext context, phone) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil
          .post('/api/auth/check-register', {"phone": phone.text});
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.to(
          () => ResetPassVerifyPage(
            phone: phone.text,
            email: '',
          ),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );
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

  checkRegisterEmail<String>(BuildContext context, email) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil
          .post('/api/auth/check-register-mail', {"email": email.text});
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.to(
          () => ResetPassVerifyPage(
            email: email.text,
            phone: '',
          ),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeftWithFade,
        );
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

  setPassword(BuildContext context, phone, email) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/set-password', {
        'phone': phone,
        'email': email,
        'password': password.text,
        'isEdit': true,
      });
      print('response $response');
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.offAllNamed("/login");
        password.clear();
        passwordConfirm.clear();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  changePassword(BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/change-pass', {
        'id': appController.user.value.id,
        'current_pass': oldPassword.text,
        'new_pass': password.text,
      });
      print('response $response');
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await Future.delayed(const Duration(seconds: 1));
        pr.hide();
        // Get.offAllNamed("/login");
        Navigator.pop(context);
        password.clear();
        passwordConfirm.clear();
      } else {
        pr.update(message: response['msg'], type: 'error');
        await Future.delayed(const Duration(milliseconds: 1500));
        pr.hide();
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
    }
  }

  doVerifyPhone<String>(BuildContext context, phone) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/reset-verify',
          {"phone": phoneNumber, "verify_code": verCode.text});

      if (response != null && response['status'] == true) {
        isFail = false;
        update();
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.to(
          () => NewPassScreen(
            phone: phone,
            email: '',
          ),
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

  doVerifyMail<String>(BuildContext context, email) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/auth/reset-verify-mail',
          {"email": emailAdr, "verify_code": verCode.text});

      if (response != null && response['status'] == true) {
        isFail = false;
        update();
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        Get.to(
          () => NewPassScreen(
            phone: '',
            email: email,
          ),
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

  reSendSms<String>(BuildContext context, phone) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response =
          await _netUtil.post('/api/auth/resendSms', {"phone": phone});
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

  reSendEmail<String>(BuildContext context, email) async {
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

  // // ---------------------------- use htpp --------------------------------

  // checkRegisterPhone(BuildContext context, phone) async {
  //   ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   await Future.delayed(Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();

  //   String url = 'http://10.0.2.2:8000/api/auth/check-register';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       'phone': phone.text,
  //     });

  //     if (responseFirst.statusCode == 200) {
  //       var response = jsonDecode(responseFirst.body);
  //       if (response != null && response['status'] == true) {
  //         pr.update(message: response['msg'], type: 'success');
  //         await new Future.delayed(const Duration(seconds: 1));
  //         pr.hide();
  //         Get.to(
  //           () => ResetPassVerifyPage(
  //             phone: phone.text,
  //             email: '',
  //           ),
  //           duration: const Duration(milliseconds: 500),
  //           transition: Transition.rightToLeftWithFade,
  //         );
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

  // checkRegisterEmail(BuildContext context, email) async {
  //   ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   await Future.delayed(Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();
  //   String url = 'http://10.0.2.2:8000/api/auth/check-register-mail';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       'email': email.text,
  //     });

  //     if (responseFirst.statusCode == 200) {
  //       var response = jsonDecode(responseFirst.body);
  //       if (response != null && response['status'] == true) {
  //         pr.update(message: response['msg'], type: 'success');
  //         await new Future.delayed(const Duration(seconds: 1));
  //         pr.hide();
  //         Get.to(
  //           () => ResetPassVerifyPage(
  //             email: email.text,
  //             phone: '',
  //           ),
  //           duration: const Duration(milliseconds: 500),
  //           transition: Transition.rightToLeftWithFade,
  //         );
  //       } else {
  //         pr.update(message: response['msg'], type: 'error');
  //         await new Future.delayed(const Duration(milliseconds: 1500));
  //         pr.hide();
  //       }
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // setPassword(BuildContext context, phone, email) async {
  //   ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();

  //   String url = 'http://10.0.2.2:8000/api/auth/set-password';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       'phone': phone,
  //       'email': email,
  //       'password': password.text,
  //     });

  //     if (responseFirst.statusCode == 200) {
  //       var response = jsonDecode(responseFirst.body);
  //       print('response $response');
  //       if (response != null && response['status'] == true) {
  //         pr.update(message: response['msg'], type: 'success');
  //         await Future.delayed(const Duration(seconds: 1));
  //         pr.hide();
  //         Get.offAllNamed("/login");
  //         password.clear();
  //         passwordConfirm.clear();
  //       } else {
  //         pr.update(message: response['msg'], type: 'error');
  //         await Future.delayed(const Duration(milliseconds: 1500));
  //         pr.hide();
  //       }
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // doVerifyPhone(BuildContext context, phone) async {
  //   ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   await Future.delayed(Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();

  //   String url = 'http://10.0.2.2:8000/api/auth/reset-verify';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       'phone': phoneNumber,
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
  //           () => NewPassScreen(
  //             phone: phone,
  //             email: '',
  //           ),
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
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // doVerifyMail(BuildContext context, email) async {
  //   ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   await Future.delayed(Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();

  //   String url = 'http://10.0.2.2:8000/api/auth/reset-verify-mail';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       'email': emailAdr,
  //       "verify_code": verCode.text,
  //     });

  //     if (responseFirst.statusCode == 200) {
  //       var response = jsonDecode(responseFirst.body);
  //       print('verify ---- response -----$response');
  //       if (response != null && response['status'] == true) {
  //         isFail = false;
  //         update();
  //         pr.update(message: response['msg'], type: 'success');
  //         await new Future.delayed(const Duration(seconds: 1));
  //         pr.hide();
  //         Get.to(
  //           () => NewPassScreen(
  //             phone: "",
  //             email: email,
  //           ),
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
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // reSendSms(BuildContext context, phone) async {
  //   ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   await Future.delayed(Duration(milliseconds: 300));
  //   pr.setMessage('alert_tur_huleene_uu'.tr);
  //   pr.show();

  //   String url = 'http://10.0.2.2:8000/api/auth/resendSms';

  //   try {
  //     final responseFirst = await http.post(Uri.parse(url), body: {
  //       'phone': phone,
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
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // reSendEmail(BuildContext context, email) async {
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
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
}
