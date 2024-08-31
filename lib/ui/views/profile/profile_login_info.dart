// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/controllers/authentication/get_info_controller.dart';
import 'package:move_to_earn/ui/views/profile/update_login_info.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';

class LoginInfo extends StatefulWidget {
  const LoginInfo({super.key});

  @override
  State<LoginInfo> createState() => _LoginInfoState();
}

class _LoginInfoState extends State<LoginInfo> {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  LanguageController languageController = Get.find();
  GetInfoController getInfoCtrl = Get.put(GetInfoController());
  PageController pageController = new PageController();

  // SharedPreferences? _prefs;
  int? weightKG = 50;
  int? _weightInitialItem = 30;

  int? cmHeight = 170;
  int? _heightInitialItem = 120;

  List<dynamic> _sumDuureg = [];
  String? selectedAimag;
  // String? selectedSum;
  bool isAimagSelected = false;

  @override
  void initState() {
    super.initState();
    if (appController.user.value.phone != null) {
      ctrl.phoneNumberView = appController.user.value.phone!;
    }
    if (appController.user.value.email != null) {
      ctrl.emailCtrl = appController.user.value.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCtrl>(
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
                    'pp_nevtreh_medeelel'.tr,
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'r2_utasnii_dugaar'.tr,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  InkWell(
                                    onTap: () async {
                                      ctrl.phone.clear();
                                      updatePhone(context);
                                    },
                                    child: Container(
                                      // height: 60.h,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          top: 8.h,
                                          right: 12.w,
                                          left: 12.w,
                                          bottom: 8.h),
                                      decoration: BoxDecoration(
                                        color: mainWhite.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.r),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ctrl.phoneNumberView ??
                                                'pep_utasnii_dugaar'.tr,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          // Icon(
                                          //   Icons
                                          //       .keyboard_arrow_down_rounded,
                                          //   color: mainWhite,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'pep_email_hayg'.tr,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  InkWell(
                                    onTap: () async {
                                      ctrl.email.clear();
                                      updateEmail(context);
                                    },
                                    child: Container(
                                      // height: 60.h,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          top: 8.h,
                                          right: 12.w,
                                          left: 12.w,
                                          bottom: 8.h),
                                      decoration: BoxDecoration(
                                        color: mainWhite.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.r),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ctrl.emailCtrl ??
                                                'pep_email_hayg'.tr,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          // Icon(
                                          //   Icons
                                          //       .keyboard_arrow_down_rounded,
                                          //   color: mainWhite,
                                          // ),
                                        ],
                                      ),
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
                // bottomNavigationBar: SafeArea(
                //   child: LoginSignUpButton(
                //     model: ButtonModel(
                //         color1: Colors.transparent,
                //         color2: Colors.transparent,
                //         color3: Colors.transparent,
                //         color4: Colors.transparent,
                //         color5: Colors.transparent,
                //         borderColor: ColorConstants.neutralColor2,
                //         text: "pep_hadgalah".tr,
                //         icon: "",
                //         textStyle: TTextTheme.lightTextTheme.bodySmall,
                //         getTo: () {
                //           final form = ctrl.profileFormKey.currentState;
                //           if (form!.validate()) {
                //             form.save();
                //             ctrl.editUserInformation(context);
                //           }
                //         }),
                //   ),
                // ),
              ),
            ),
          ],
        );
      },
    );
  }
}
