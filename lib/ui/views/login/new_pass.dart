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
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/models/model_name_input.dart';

import '../../component/inputs/name_pass_input.dart';

class NewPassScreen extends StatefulWidget {
  final String phone;
  final String email;
  const NewPassScreen({super.key, required this.phone, required this.email});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  bool btnActivePass = false;
  bool btnActivePassAgain = false;
  ResetPasswordController ctrl = Get.put(ResetPasswordController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    btnActivePass = false;
    btnActivePassAgain = false;
    // ctrl.password.clear();
    // ctrl.passwordConfirm.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
        init: ctrl,
        builder: (logic) {
          return GestureDetector(
            onTap: () {
              // Hide the keyboard when tapped outside the text input area
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              body: Stack(
                children: [
                  BackColor(),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(signupImage3),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  HeaderForPage(
                    backArrow: BackArrow(),
                    text: 'pr_nuuts_vg'.tr,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: inputPaddingTop.h),
                    child: Form(
                      key: ctrl.formKey,
                      child: Column(
                        children: [
                          NamePassInput(
                            model: InputModel(
                                inputType: TextInputType.text,
                                maxLength: 16,
                                onChanged: (value) {
                                  setState(() {
                                    btnActivePass =
                                        value.length >= 1 ? true : false;
                                  });
                                },
                                controller: ctrl.password,
                                obscureText: ctrl.toggleEye,
                                hintText: "pr_nuuts_vg".tr,
                                prefixIcon: Iconsax.password_check,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ctrl.toggleEye = !ctrl.toggleEye;
                                    ctrl.update();
                                  },
                                  icon: Icon(
                                    ctrl.toggleEye
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.white,
                                    size: 22.sp,
                                  ),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'pr_nuuts_vgee_oruulnuu'.tr;
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          SizedBox(height: spaceBetweenInputs.h),
                          NamePassInput(
                            model: InputModel(
                              inputType: TextInputType.text,
                              maxLength: 16,
                              onChanged: (value) {
                                setState(() {
                                  btnActivePassAgain =
                                      value.length >= 1 ? true : false;
                                });
                              },
                              controller: ctrl.passwordConfirm,
                              obscureText: ctrl.toggleEye2,
                              hintText: 'pr_nuuts_vgee_dawtah'.tr,
                              prefixIcon: Iconsax.password_check,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  ctrl.toggleEye2 = !ctrl.toggleEye2;
                                  ctrl.update();
                                },
                                icon: Icon(
                                  ctrl.toggleEye2
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.white,
                                  size: 22.sp,
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'pr_nuuts_vgee_oruulnuu'.tr;
                                } else if (val != ctrl.password.text) {
                                  return 'pr_nuuts_vg_taarhgvi_baina'.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: buttonBottomSpace.h,
                    left: 20.w,
                    right: 20.w,
                    child: GradientButtonSmall(
                      text: 'pr_vrgeljlvvleh'.tr,
                      color1: btnActivePass == true
                          ? ColorConstants.buttonGradient2
                          : Colors.transparent,
                      color2: btnActivePass == true
                          ? ColorConstants.buttonGradient1
                          : Colors.transparent,
                      textColor: mainWhite,
                      isShadow: false,
                      isBorder: btnActivePass == true ? false : true,
                      onPressed: () {
                        final form = ctrl.formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          ctrl.setPassword(context, widget.phone, widget.email);
                        }
                      },
                    ),
                    // LoginSignUpButton(
                    //   model: ButtonModel(
                    //       color1: btnActivePass == true
                    //           ? ColorConstants.gradientColor1
                    //           : Colors.transparent,
                    //       color2: btnActivePass == true
                    //           ? ColorConstants.gradientColor2
                    //           : Colors.transparent,
                    //       color3: btnActivePass == true
                    //           ? ColorConstants.gradientColor3
                    //           : Colors.transparent,
                    //       color4: btnActivePass == true
                    //           ? ColorConstants.gradientColor4
                    //           : Colors.transparent,
                    //       color5: btnActivePass == true
                    //           ? ColorConstants.gradientColor5
                    //           : Colors.transparent,
                    //       borderColor: btnActivePass == true
                    //           ? Colors.transparent
                    //           : ColorConstants.neutralColor2,
                    //       text: 'pr_vrgeljlvvleh'.tr,
                    //       icon: "",
                    //       textStyle: TTextTheme.lightTextTheme.bodySmall,
                    //       getTo: () {
                    //         final form = ctrl.formKey.currentState;
                    //         if (form!.validate()) {
                    //           form.save();
                    //           ctrl.setPassword(
                    //               context, widget.phone, widget.email);
                    //         }
                    //       },
                    //       ),
                    // )
                  ),
                ],
              ),
            ),
          );
        });
  }
}
