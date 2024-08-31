import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/controllers/authentication/reset_controller.dart';
import 'package:move_to_earn/core/models/model_name_input.dart';
import 'package:move_to_earn/ui/component/inputs/name_pass_input.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import '../../../core/constants/colors.dart';
import '../../../core/models/model_button.dart';
import '../../../utils/theme/widget_theme/text_theme.dart';
import '../../component/buttons/gradient_button_old.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool btnActivePass = false;
  bool btnActivePassAgain = false;
  bool btnActivePassAgain1 = false;
  ResetPasswordController ctrl = Get.put(ResetPasswordController());

  @override
  void initState() {
    super.initState();
    btnActivePass = false;
    btnActivePassAgain = false;
    btnActivePassAgain1 = false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ctrl,
      builder: (logic) {
        return Stack(
          children: [
            BackColor(),
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: BackArrow(),
                  title: Text(
                    'l2_nuuts_vg'.tr,
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito Sans',
                        letterSpacing: -0.5),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                              child: Column(
                                children: [
                                  Form(
                                    key: ctrl.formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 12.h),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'pp_currentpassword'.tr,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: buttonSpaceSize.h),
                                        NamePassInput(
                                          model: InputModel(
                                              inputType: TextInputType.text,
                                              maxLength: 16,
                                              onChanged: (value) {
                                                setState(() {
                                                  btnActivePass =
                                                      value.length >= 1
                                                          ? true
                                                          : false;
                                                });
                                              },
                                              controller: ctrl.oldPassword,
                                              obscureText: ctrl.toggleEye,
                                              hintText: "pp_currentpassword".tr,
                                              prefixIcon:
                                                  Iconsax.password_check,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  ctrl.toggleEye =
                                                      !ctrl.toggleEye;
                                                  ctrl.update();
                                                },
                                                icon: Icon(
                                                  ctrl.toggleEye
                                                      ? Icons
                                                          .visibility_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color: Colors.white,
                                                  size: 22.sp,
                                                ),
                                              ),
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'pr_nuuts_vgee_oruulnuu'
                                                      .tr;
                                                } else {
                                                  return null;
                                                }
                                              }),
                                        ),
                                        SizedBox(height: 15.h),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'pp_newpassword'.tr,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: buttonSpaceSize.h),
                                        NamePassInput(
                                          model: InputModel(
                                              inputType: TextInputType.text,
                                              maxLength: 16,
                                              onChanged: (value) {
                                                setState(() {
                                                  btnActivePassAgain =
                                                      value.length >= 1
                                                          ? true
                                                          : false;
                                                });
                                              },
                                              controller: ctrl.password,
                                              obscureText: ctrl.toggleEye1,
                                              hintText: "pp_newpassword".tr,
                                              prefixIcon:
                                                  Iconsax.password_check,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  ctrl.toggleEye1 =
                                                      !ctrl.toggleEye1;
                                                  ctrl.update();
                                                },
                                                icon: Icon(
                                                  ctrl.toggleEye1
                                                      ? Icons
                                                          .visibility_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color: Colors.white,
                                                  size: 22.sp,
                                                ),
                                              ),
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'pr_nuuts_vgee_oruulnuu'
                                                      .tr;
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
                                                btnActivePassAgain1 =
                                                    value.length >= 1
                                                        ? true
                                                        : false;
                                              });
                                            },
                                            controller: ctrl.passwordConfirm,
                                            obscureText: ctrl.toggleEye2,
                                            hintText: 'pr_nuuts_vgee_dawtah'.tr,
                                            prefixIcon: Iconsax.password_check,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                ctrl.toggleEye2 =
                                                    !ctrl.toggleEye2;
                                                ctrl.update();
                                              },
                                              icon: Icon(
                                                ctrl.toggleEye2
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: Colors.white,
                                                size: 22.sp,
                                              ),
                                            ),
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'pr_nuuts_vgee_oruulnuu'
                                                    .tr;
                                              } else if (val !=
                                                  ctrl.password.text) {
                                                return 'pr_nuuts_vg_taarhgvi_baina'
                                                    .tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: LoginSignUpButton(
                      model: ButtonModel(
                          color1: Colors.transparent,
                          color2: Colors.transparent,
                          color3: Colors.transparent,
                          color4: Colors.transparent,
                          color5: Colors.transparent,
                          borderColor: ColorConstants.neutralColor2,
                          text: "pep_hadgalah".tr,
                          icon: "",
                          textStyle: TTextTheme.lightTextTheme.bodySmall,
                          getTo: () {
                            final form = ctrl.formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              ctrl.changePassword(context);
                            }
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
