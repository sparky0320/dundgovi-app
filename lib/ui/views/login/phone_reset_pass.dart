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

class PhoneResetPassScreen extends StatefulWidget {
  const PhoneResetPassScreen({super.key});

  @override
  State<PhoneResetPassScreen> createState() => _PhoneResetPassScreenState();
}

class _PhoneResetPassScreenState extends State<PhoneResetPassScreen> {
  ResetPasswordController ctrl = Get.put(ResetPasswordController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctrl.phone.clear();
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
                        controller: ctrl.phone,
                        inputType: TextInputType.number,
                        maxLength: phoneMaxLength,
                        hintText: 'pr_utasnii_dugaar'.tr,
                        prefixIcon: Icons.phone_iphone_outlined,
                        onChanged: (val) {
                          ctrl.phoneLength = val.length;
                          ctrl.update();
                        }),
                  ),
                ),
                Positioned(
                    bottom: buttonBottomSpace.h,
                    left: 20.w,
                    right: 20.w,
                    child: GradientButtonSmall(
                      text: 'pr_vrgeljlvvleh'.tr,
                      color1: ctrl.phoneLength > 7
                          ? ColorConstants.buttonGradient2
                          : Colors.transparent,
                      color2: ctrl.phoneLength > 7
                          ? ColorConstants.buttonGradient1
                          : Colors.transparent,
                      textColor: mainWhite,
                      isShadow: false,
                      isBorder: ctrl.phoneLength > 7 ? false : true,
                      onPressed: () {
                        if (ctrl.phoneLength == 0) {
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
                                  'pr_utasnuu_dugaaraa_oruulnuu'.tr,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h));
                          }
                        } else if (ctrl.phoneLength < 8) {
                          if (!Get.isSnackbarOpen) {
                            Get.snackbar("", "",
                                icon: Icon(Iconsax.warning_2,
                                    color: Colors.yellow, size: 32.sp),
                                snackPosition: SnackPosition.TOP,
                                titleText: Text(
                                  'pr_utasnii_dugaar_buruu_baina'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                messageText: Text(
                                  'pr_utasnii_dugaaraa_zow_oruulnuu'.tr,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h));
                          }
                        } else {
                          ctrl.checkRegisterPhone(context, ctrl.phone);
                        }
                      },
                    )
                    // LoginSignUpButton(
                    //   model: ButtonModel(
                    //     color1: ctrl.phoneLength > 7
                    //         ? ColorConstants.gradientColor1
                    //         : Colors.transparent,
                    //     color2: ctrl.phoneLength > 7
                    //         ? ColorConstants.gradientColor2
                    //         : Colors.transparent,
                    //     color3: ctrl.phoneLength > 7
                    //         ? ColorConstants.gradientColor3
                    //         : Colors.transparent,
                    //     color4: ctrl.phoneLength > 7
                    //         ? ColorConstants.gradientColor4
                    //         : Colors.transparent,
                    //     color5: ctrl.phoneLength > 7
                    //         ? ColorConstants.gradientColor5
                    //         : Colors.transparent,
                    //     borderColor: ctrl.phoneLength > 7
                    //         ? Colors.transparent
                    //         : ColorConstants.neutralColor2,
                    //     text: 'pr_vrgeljlvvleh'.tr,
                    //     icon: "",
                    //     textStyle: TTextTheme.lightTextTheme.bodySmall,
                    //     getTo:
                    //     () {
                    //       if (ctrl.phoneLength == 0) {
                    //         if (!Get.isSnackbarOpen) {
                    //           Get.snackbar("", "",
                    //               icon: Icon(Iconsax.warning_2,
                    //                   color: Colors.yellow, size: 32.sp),
                    //               snackPosition: SnackPosition.TOP,
                    //               titleText: Text(
                    //                 'r2_talbariig_gvitsed_boglono_vv'.tr,
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 16.sp,
                    //                     fontWeight: FontWeight.w500),
                    //               ),
                    //               messageText: Text(
                    //                 'pr_utasnuu_dugaaraa_oruulnuu'.tr,
                    //                 style: TextStyle(
                    //                     color: Colors.grey, fontSize: 12.sp),
                    //               ),
                    //               backgroundColor: Colors.white,
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 16.w, vertical: 12.h));
                    //         }
                    //       } else if (ctrl.phoneLength < 8) {
                    //         if (!Get.isSnackbarOpen) {
                    //           Get.snackbar("", "",
                    //               icon: Icon(Iconsax.warning_2,
                    //                   color: Colors.yellow, size: 32.sp),
                    //               snackPosition: SnackPosition.TOP,
                    //               titleText: Text(
                    //                 'pr_utasnii_dugaar_buruu_baina'.tr,
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 16.sp,
                    //                     fontWeight: FontWeight.w500),
                    //               ),
                    //               messageText: Text(
                    //                 'pr_utasnii_dugaaraa_zow_oruulnuu'.tr,
                    //                 style: TextStyle(
                    //                     color: Colors.grey, fontSize: 12.sp),
                    //               ),
                    //               backgroundColor: Colors.white,
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 16.w, vertical: 12.h));
                    //         }
                    //       } else {
                    //         ctrl.checkRegisterPhone(context, ctrl.phone);
                    //       }
                    //     },
                    //   ),
                    // ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
