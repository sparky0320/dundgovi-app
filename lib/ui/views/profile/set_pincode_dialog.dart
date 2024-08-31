import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/pincode_controller.dart';
import 'package:pinput/pinput.dart';

setPinCodeDialog(context) {
  PinCodeCtrl ctrl = Get.put(PinCodeCtrl());
  return showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0.r)),
      child: GetBuilder<PinCodeCtrl>(builder: (logic) {
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
                    "tpc_gvilgeenii_pin_code".tr,
                    style: TextStyle(
                      color: Color(0xff584A73),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "tpc_description".tr,
                    style: TextStyle(
                      color: Color(0xff878787),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Pinput(
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                    controller: ctrl.pinController,
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
                    onCompleted: (pin) async {
                      await ctrl.setPinCode(context);
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

OutlineInputBorder inputStyle() {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 0.w, color: Colors.transparent),
    borderRadius: BorderRadius.circular(10.r),
  );
}
