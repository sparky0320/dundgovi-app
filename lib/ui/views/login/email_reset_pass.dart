import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/authentication/reset_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/models/model_name_input.dart';
import '../../component/inputs/name_pass_input.dart';

class EmailResetPassScreen extends StatefulWidget {
  const EmailResetPassScreen({super.key});

  @override
  State<EmailResetPassScreen> createState() => _EmailResetPassScreenState();
}

class _EmailResetPassScreenState extends State<EmailResetPassScreen> {
  ResetPasswordController ctrl = Get.put(ResetPasswordController());
  bool btnActiveEmail = false;
  bool btnActiveCount = false;

  @override
  void initState() {
    super.initState();
    ctrl.email.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ctrl,
      builder: (logic) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(
              children: [
                BackColor(),
                HeaderForPage(
                  backArrow: BackArrow(),
                  text: 'pr_nuut_vg_sergeeh'.tr,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: inputPaddingTop.h),
                  child: NamePassInput(
                    model: InputModel(
                      controller: ctrl.email,
                      inputType: TextInputType.emailAddress,
                      maxLength: 40,
                      hintText: 'l2_email'.tr,
                      prefixIcon: Icons.mail,
                      onChanged: (val) {
                        setState(() {
                          btnActiveCount = val.length >= 1 ? true : false;
                          btnActiveEmail =
                              RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(val)
                                  ? true
                                  : false;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: buttonBottomSpace.h,
                  left: 20.w,
                  right: 20.w,
                  child: GradientButtonSmall(
                      text: 'pr_vrgeljlvvleh'.tr,
                      color1: btnActiveEmail && btnActiveCount
                          ? ColorConstants.buttonGradient2
                          : Colors.transparent,
                      color2: btnActiveEmail && btnActiveCount
                          ? ColorConstants.buttonGradient1
                          : Colors.transparent,
                      textColor: mainWhite,
                      isShadow: false,
                      isBorder: btnActiveEmail && btnActiveCount ? false : true,
                      onPressed: () {
                        if (btnActiveCount == false) {
                          if (!Get.isSnackbarOpen) {
                            Get.snackbar("", "",
                                icon: Icon(Iconsax.warning_2,
                                    color: Colors.yellow, size: 32.sp),
                                snackPosition: SnackPosition.TOP,
                                titleText: Text(
                                  'r2_talbariig_gvitsed_boglono_vv'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                messageText: Text(
                                  'r2_email_haygaa_oruulna_uu'.tr,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h));
                          }
                        } else if (btnActiveEmail == false) {
                          if (!Get.isSnackbarOpen) {
                            Get.snackbar("", "",
                                icon: Icon(Iconsax.warning_2,
                                    color: Colors.yellow, size: 32.sp),
                                snackPosition: SnackPosition.TOP,
                                titleText: Text(
                                  'r2_email_buruu_baina'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                messageText: Text(
                                  'r2_email_zow_oruulnuu'.tr,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h));
                          }
                        } else {
                          ctrl.checkRegisterEmail(context, ctrl.email);
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
