import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_pin_code_controller/challenge_pin_code_controller.dart';
import 'package:pinput/pinput.dart';

challengePinCodeDialog(context, ChallengeModel data, String pin) {
  ChallengePinCodeCtrl ctrl = Get.put(ChallengePinCodeCtrl());
  return showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0.r)),
      child: GetBuilder<ChallengePinCodeCtrl>(builder: (logic) {
        return Padding(
          padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h, bottom: 6.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "cp_challenge_pin_code".tr,
                    style: TextStyle(
                      color: Color(0xff584A73),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Pinput(
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                    // controller: ctrl.pinController,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // obscureText: true,
                    defaultPinTheme: PinTheme(
                      width: 52.w,
                      height: 52.h,
                      textStyle: TextStyle(
                          fontSize: 22.sp,
                          color: mainBlack,
                          fontWeight: FontWeight.w500),
                      decoration: BoxDecoration(
                        border: Border.all(color: mainBlack),
                        borderRadius: BorderRadius.circular(6.r),
                        color: mainWhite,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 4.r,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                    showCursor: true,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    onCompleted: (val) async {
                      ctrl.pinController.text = val;
                      await ctrl.checkPinCode(context, data, pin);
                    },
                  ),
                  SizedBox(height: 12.h),
                  ctrl.isFail
                      ? Text(ctrl.errorMsg,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: mainRed,
                              fontWeight: FontWeight.w400))
                      : SizedBox(),
                  SizedBox(height: 40.h),
                ],
              ),
            ],
          ),
        );
      }),
    ),
  );
}
