import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/text_strings.dart';

class FaceIdCheckbox extends StatelessWidget {
  final RxBool isFaceIdEnabled = false.obs;

  @override
  Widget build(BuildContext context) {
    LocalAuthentication().canCheckBiometrics.then((value) {
      isFaceIdEnabled.value = value == true;
    });
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.5,
      child: Obx(
        () => CheckboxListTile(
          checkColor: ColorConstants.neutralColor3,
          activeColor: ColorConstants.neutralColor2,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            faceIdText,
            style: TextStyle(
              color: Color(0xFFEEEEEE).withOpacity(0.6),
              fontSize: 13.w,
              fontWeight: FontWeight.w400,
            ),
          ),
          value: isFaceIdEnabled.value && isFaceIdEnabled.value,
          onChanged: isFaceIdEnabled.value
              ? (value) {
                  isFaceIdEnabled.value = value!;
                }
              : null,
        ),
      ),
    );
  }
}
