import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/core/constants/controllers.dart';

class PinCodeCtrl extends GetxController {
  final pinController = TextEditingController();
  NetworkUtil _netUtil = NetworkUtil();
  bool isFail = false;
  bool isPinCodeCorrect = false;
  String errorMsg = '';

  setPinCode<String>(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/set/pincode', {
        "user_id": appController.user.value.id,
        "code": pinController.text,
      });
      print('verify ---- response -----$response');
      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        isFail = false;
        update();
        Navigator.pop(context);
        pinController.clear();
        return true;
      } else {
        errorMsg = response['msg'];
        isFail = true;
        update();
        pinController.clear();
        pr.hide();
        return false;
      }
    } catch (e) {
      errorMsg = e.toString();
      isFail = true;
      update();
      pinController.clear();
      pr.hide();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );

      return false;
    }
  }

  checkPinCode(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 500));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();
    try {
      var response = await _netUtil.post('/api/check/pincode', {
        "user_id": appController.user.value.id,
        "pin": pinController.text,
      });

      if (response != null && response['status'] == true) {
        pr.update(message: response['msg'], type: 'success');
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        isPinCodeCorrect = true;
        update();
        Navigator.pop(context);
        pinController.clear();
        return true;
      } else {
        pr.update(
            message: response['msg'] != null
                ? response['msg']
                : "Таны гүйлгээний пинкод буруу байна",
            type: 'error');
        await new Future.delayed(const Duration(seconds: 2));
        pr.hide();
        // errorMsg = response['msg'];
        isPinCodeCorrect = false;
        isFail = true;
        update();
        pinController.clear();
        return false;
      }
    } catch (e) {
      pr.update(message: e.toString(), type: 'error');
      await new Future.delayed(const Duration(seconds: 2));
      pr.hide();
      // errorMsg = response['msg'];
      isPinCodeCorrect = false;
      isFail = true;
      update();
      pinController.clear();
      FirebaseCrashlytics.instance.recordError(
        Exception(e),
        StackTrace.current, // you should pass stackTrace in here
        reason: e,
        fatal: false,
      );
      return false;
    }
  }
}
