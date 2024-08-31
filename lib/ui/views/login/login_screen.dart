import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/controllers/authentication/login_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/ui/views/login/email_reset_pass.dart';
import 'package:move_to_earn/ui/views/login/phone_reset_pass.dart';

import 'package:move_to_earn/ui/views/welcome/welcome_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/values.dart';
import '../../../core/models/model_name_input.dart';
import '../../../utils/theme/widget_theme/text_theme.dart';
import '../../component/inputs/name_pass_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool btnActiveName = false;
  bool btnActivePass = false;
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // // Login google button
    // final signGoogleButton = LoginSignUpButton(
    //   model: ButtonModel(
    //       color1: ColorConstants.gradientColor1,
    //       color2: ColorConstants.gradientColor2,
    //       color3: ColorConstants.gradientColor3,
    //       color4: ColorConstants.gradientColor4,
    //       color5: ColorConstants.gradientColor5,
    //       borderColor: Colors.transparent,
    //       text: signGoogleText,
    //       icon: googleIcon,
    //       textStyle: TTextTheme.darkTextTheme.bodySmall,
    //       getTo: () => {}),
    // );

    return GetBuilder<LoginController>(
      init: controller,
      builder: (logic) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          // key: controller.scaffoldKey,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Stack(
                      children: [
                        BackColor(),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3),
                          child: Container(
                            // padding: EdgeInsets.only(
                            //     top: MediaQuery.of(context).size.height / 2),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(loginBackImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        HeaderForPage(
                            backArrow: IconButton(
                              iconSize: 32.w,
                              icon: Icon(
                                Icons.chevron_left,
                                color: mainWhite,
                              ),
                              color: ColorConstants.whiteColor,
                              onPressed: () {
                                Get.to(
                                  () => WelcomeScreen(),
                                  duration: const Duration(milliseconds: 800),
                                  transition: Transition.leftToRightWithFade,
                                );
                              },
                            ),
                            text: "l2_newtreh".tr),
                        Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: inputPaddingTop.h),
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    ToggleButtons(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      selectedBorderColor: Colors.white,
                                      selectedColor: Colors.white,
                                      fillColor: mainWhite.withOpacity(0.2),
                                      borderColor: Colors.white54,
                                      color: textGrey,
                                      constraints: BoxConstraints(
                                        minHeight: 40.h,
                                        minWidth: resWidth(context) * 0.4,
                                      ),
                                      isSelected:
                                          controller.selectedLoginOptions,
                                      onPressed: (int index) {
                                        for (int i = 0;
                                            i <
                                                controller.selectedLoginOptions
                                                    .length;
                                            i++) {
                                          controller.selectedLoginOptions[i] =
                                              i == index;
                                        }
                                        FocusScope.of(context).unfocus();
                                        controller.update();
                                        controller.phone.clear();
                                        controller.email.clear();
                                        btnActiveName = false;
                                      },
                                      children: <Widget>[
                                        Text('l2_email'.tr),
                                        Text('l2_utasnii_dugaar'.tr),
                                      ],
                                    ),
                                    SizedBox(height: spaceBetweenInputs.h),

                                    controller.selectedLoginOptions[0] == true
                                        ? NamePassInput(
                                            model: InputModel(
                                              inputType:
                                                  TextInputType.emailAddress,
                                              maxLength: 50,
                                              onChanged: (value) {
                                                setState(() {
                                                  btnActiveName =
                                                      value.length >= 1
                                                          ? true
                                                          : false;
                                                });
                                              },
                                              controller: controller.email,
                                              hintText: 'l2_email'.tr,
                                              prefixIcon: Icons.email_outlined,
                                            ),
                                          )
                                        : NamePassInput(
                                            model: InputModel(
                                              inputType: TextInputType.number,
                                              maxLength: phoneMaxLength,
                                              onChanged: (value) {
                                                setState(() {
                                                  btnActiveName =
                                                      value.length >= 1
                                                          ? true
                                                          : false;
                                                });
                                              },
                                              controller: controller.phone,
                                              hintText: 'l2_utasnii_dugaar'.tr,
                                              prefixIcon:
                                                  Icons.phone_iphone_outlined,
                                            ),
                                          ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: spaceBetweenInputs.h,
                                          bottom: 10.h),
                                      child: NamePassInput(
                                        model: InputModel(
                                          maxLength: passMaxLength,
                                          onChanged: (value) {
                                            setState(() {
                                              btnActivePass = value.length >= 1
                                                  ? true
                                                  : false;
                                            });
                                          },
                                          obscureText: controller.toggleEye,
                                          controller: controller.password,
                                          hintText: 'l2_nuuts_vg'.tr,
                                          prefixIcon: Iconsax.password_check,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.toggleEye =
                                                  !controller.toggleEye;
                                              controller.update();
                                            },
                                            icon: Icon(
                                              controller.toggleEye
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: mainWhite,
                                              size: 22.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // FaceIdCheckbox(),
                                    SizedBox(height: 13.h),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(
                                          controller.selectedLoginOptions[0] ==
                                                  true
                                              ? () => EmailResetPassScreen()
                                              : () => PhoneResetPassScreen(),
                                          duration:
                                              const Duration(milliseconds: 500),
                                          transition:
                                              Transition.rightToLeftWithFade,
                                        );
                                      },
                                      child: Text(
                                        "l2_nuuts_vg_sergeeh".tr,
                                        style: TTextTheme
                                            .darkTextTheme.displaySmall,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GradientButtonSmall(
                                      color1: btnActiveName && btnActivePass
                                          ? ColorConstants.buttonGradient2
                                          : Colors.transparent,
                                      color2: btnActiveName && btnActivePass
                                          ? ColorConstants.buttonGradient1
                                          : Colors.transparent,
                                      text: 'l2_newtreh'.tr,
                                      textColor: mainWhite,
                                      isShadow: false,
                                      isBorder: btnActiveName && btnActivePass
                                          ? false
                                          : true,
                                      onPressed: btnActiveName &&
                                              btnActivePass == true
                                          ? () => controller.doLogin(context)
                                          : () => {
                                                if (!Get.isSnackbarOpen)
                                                  {
                                                    Get.snackbar(
                                                      "l2_talbariig_gvitsed_boglonvv"
                                                          .tr,
                                                      "l2_utas_eswel_nuuts_vgee_orulagvi_bn"
                                                          .tr,
                                                      icon: Icon(
                                                          Iconsax.warning_2,
                                                          color: Colors.yellow,
                                                          size: 32.sp),
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      backgroundColor:
                                                          Colors.white,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.w,
                                                              vertical: 12.h),
                                                    ),
                                                  }
                                              },
                                    ),
                                    SizedBox(height: buttonSpaceSize.w),
                                    // signGoogleButton,
                                    SizedBox(height: buttonBottomSpace.h),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
