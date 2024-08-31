import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_detail.dart';

class ChallengePinCodeCtrl extends GetxController {
  final pinController = TextEditingController();
  // NetworkUtil _netUtil = NetworkUtil();
  bool isFail = false;
  bool isPinCodeCorrect = false;
  String errorMsg = '';

  checkPinCode(BuildContext context, ChallengeModel data, String pin) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 500));
    pr.setMessage('alert_tur_huleene_uu'.tr);
    pr.show();

    try {
      if (pin == pinController.text) {
        await new Future.delayed(const Duration(seconds: 1));
        pr.hide();
        isPinCodeCorrect = true;
        update();
        Navigator.of(context).pop();
        Get.to(() => ChallengeDetail(data: data));
        pinController.clear();
        return true;
      } else {
        pr.update(message: "Пинкод буруу байна", type: 'error');
        await new Future.delayed(const Duration(seconds: 2));
        pr.hide();
        // errorMsg = response['msg'];
        isPinCodeCorrect = false;
        isFail = true;
        update();
        Navigator.of(context).pop();
        pinController.clear();
        return false;
      }
    } catch (error) {
      pr.update(message: "Алдаа гарлаа дахин оролдоно уу.", type: "error");
      await new Future.delayed(const Duration(seconds: 2));
      pr.hide();
      // errorMsg = response['msg'];
      isPinCodeCorrect = false;
      isFail = true;
      update();
      pinController.clear();
      return false;
    }
  }
}
