import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/controllers/authentication/register_controller.dart';
import '../../../core/models/model_name_input.dart';
import '../../../utils/theme/widget_theme/text_theme.dart';
import '../../component/inputs/name_pass_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // bool btnActiveName = false;
  bool btnActiveCount = false;
  // bool btnActiveNumber = false;
  // bool isPhone = false;
  bool btnActiveEmail = false;

  RegisterController ctrl = Get.put(RegisterController());
  @override
  void initState() {
    super.initState();
    ctrl.email.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when tapped outside the text input area
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            BackColor(),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(loginBackImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            HeaderForPage(
              backArrow: BackArrow(),
              text: "r2_bvrtgvvleh".tr,
            ),
            Container(
              margin: EdgeInsets.only(top: inputPaddingTop.h),
              child: Column(
                children: [
                  // enter email field
                  Container(
                    child: NamePassInput(
                      model: InputModel(
                        inputType: TextInputType.emailAddress,
                        maxLength: 40,
                        onChanged: (value) {
                          setState(() {
                            btnActiveCount = value.length >= 3 ? true : false;
                            btnActiveEmail =
                                RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(value)
                                    ? true
                                    : false;
                          });
                        },
                        controller: ctrl.email,
                        hintText: "rp_email_haygaa_oruulnuu".tr,
                        prefixIcon: Icons.mail,
                      ),
                    ),
                  ),

                  SizedBox(height: 40.w),

                  /// refer code

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Text("r2_urilgiin_code_oruulna_uu".tr,
                        style: TTextTheme.darkTextTheme.displaySmall),
                  ),

                  // field for invite code
                  PinCodeFields(
                    length: 6,
                    fieldBorderStyle: FieldBorderStyle.square,
                    responsive: false,
                    fieldHeight: 32.w,
                    fieldWidth: 32.w,
                    borderWidth: 2,
                    activeBorderColor: Colors.white,
                    activeBackgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(6.w),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autoHideKeyboard: false,
                    fieldBackgroundColor: Colors.transparent,
                    borderColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 17.w,
                      color: ColorConstants.neutralColor1,
                    ),
                    controller: ctrl.referCode,
                    onComplete: (String value) {
                      btnActiveEmail && btnActiveCount
                          ? ctrl.doRegister(
                              context,
                            )
                          : () {};
                    },
                  ),

                  // NamePassInput(
                  //   model: InputModel(
                  //     inputType: TextInputType.number,
                  //     maxLength: 6,
                  //     controller: ctrl.referCode,
                  //     hintText: 'Урилгын код',
                  //     prefixIcon: Iconsax.check,
                  //   ),
                  // )
                ],
              ),
            ),

            // Continue button
            Positioned(
              bottom: buttonBottomSpace.h,
              left: 20.w,
              right: 20.w,
              child: GradientButtonSmall(
                isShadow: false,
                isBorder: btnActiveEmail && btnActiveCount ? false : true,
                text: "pr_vrgeljlvvleh".tr,
                textColor: mainWhite,
                color1: btnActiveEmail && btnActiveCount
                    ? ColorConstants.buttonGradient2
                    : Colors.transparent,
                color2: btnActiveEmail && btnActiveCount
                    ? ColorConstants.buttonGradient1
                    : Colors.transparent,
                onPressed: () {
                  if (btnActiveEmail == false) {
                    if (!Get.isSnackbarOpen) {
                      Get.snackbar(
                        "",
                        "",
                        icon: Icon(
                          Iconsax.warning_2,
                          color: Colors.yellow,
                          size: 32.sp,
                        ),
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
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      );
                    }
                  } else if (btnActiveCount == false) {
                    if (!Get.isSnackbarOpen) {
                      Get.snackbar(
                        "",
                        "",
                        icon: Icon(
                          Iconsax.warning_2,
                          color: Colors.yellow,
                          size: 32.sp,
                        ),
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
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      );
                    }
                  } else {
                    ctrl.doRegister(
                      context,
                    );
                  }
                },
              ),

              // LoginSignUpButton(
              //   model: ButtonModel(
              //       color1: btnActiveEmail && btnActiveCount
              //           ? ColorConstants.gradientColor1
              //           : Colors.transparent,
              //       color2: btnActiveEmail && btnActiveCount
              //           ? ColorConstants.gradientColor2
              //           : Colors.transparent,
              //       color3: btnActiveEmail && btnActiveCount
              //           ? ColorConstants.gradientColor3
              //           : Colors.transparent,
              //       color4: btnActiveEmail && btnActiveCount
              //           ? ColorConstants.gradientColor4
              //           : Colors.transparent,
              //       color5: btnActiveEmail && btnActiveCount
              //           ? ColorConstants.gradientColor5
              //           : Colors.transparent,
              //       borderColor: btnActiveEmail && btnActiveCount
              //           ? Colors.transparent
              //           : ColorConstants.neutralColor2,
              //       text: "pr_vrgeljlvvleh".tr,
              //       icon: "",
              //       textStyle: TTextTheme.lightTextTheme.bodySmall,
              //       // getTo: () => Get.to(
              //       //   ConfirmSignupScreen(),
              //       //   duration: const Duration(milliseconds: 500),
              //       //   transition: Transition.rightToLeftWithFade,
              //       // ),
              //       getTo: btnActiveCount
              //           ? () {
              //               btnActiveEmail
              //                   ? ctrl.doRegister(
              //                       context,
              //                     )
              //                   : Get.isSnackbarOpen
              //                       ? null
              //                       : Get.snackbar("", "",
              //                           icon: Icon(Iconsax.warning_2,
              //                               color: Colors.yellow, size: 32.sp),
              //                           snackPosition: SnackPosition.TOP,
              //                           titleText: Text(
              //                             'r2_email_buruu_baina'.tr,
              //                             style: TextStyle(
              //                                 color: Colors.black,
              //                                 fontSize: 16.sp,
              //                                 fontWeight: FontWeight.w500),
              //                           ),
              //                           messageText: Text(
              //                             'r2_email_zow_oruulnuu'.tr,
              //                             style: TextStyle(
              //                                 color: Colors.grey,
              //                                 fontSize: 12.sp),
              //                           ),
              //                           backgroundColor: Colors.white,
              //                           padding: EdgeInsets.symmetric(
              //                               horizontal: 16.w, vertical: 12.h));
              //             }
              //           : () {
              //               if (!Get.isSnackbarOpen) {
              //                 Get.snackbar("", "",
              //                     icon: Icon(Iconsax.warning_2,
              //                         color: Colors.yellow, size: 32.sp),
              //                     snackPosition: SnackPosition.TOP,
              //                     titleText: Text(
              //                       'r2_talbariig_gvitsed_boglono_vv'.tr,
              //                       style: TextStyle(
              //                           color: Colors.black,
              //                           fontSize: 16.sp,
              //                           fontWeight: FontWeight.w500),
              //                     ),
              //                     messageText: Text(
              //                       'r2_email_haygaa_oruulna_uu'.tr,
              //                       style: TextStyle(
              //                           color: Colors.grey, fontSize: 12.sp),
              //                     ),
              //                     backgroundColor: Colors.white,
              //                     padding: EdgeInsets.symmetric(
              //                         horizontal: 16.w, vertical: 12.h));
              //               }
              //             }),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
