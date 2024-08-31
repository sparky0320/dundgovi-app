import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:move_to_earn/core/models/model_button.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/views/home/invite_friend.dart';
import 'package:move_to_earn/ui/views/home/modalbottoms.dart';
import 'package:move_to_earn/ui/views/profile/achievement/achievement_page.dart';
import 'package:move_to_earn/ui/views/profile/profile_change_password.dart';
import 'package:move_to_earn/ui/views/profile/profile_edit.dart';
import 'package:move_to_earn/ui/views/profile/profile_login_info.dart';
import 'package:move_to_earn/ui/views/profile/step_log.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import 'package:move_to_earn/utils/web_view_container.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../core/constants/firebase.dart';
import '../../component/buttons/transparent_button.dart';
import 'update_language.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  LanguageController languageController = Get.find();
  NetworkUtil _netUtil = new NetworkUtil();
  bool? isDev;

  MenuContainer() {
    Container(
      decoration: BoxDecoration(color: Colors.transparent.withOpacity(0.2)),
      margin: EdgeInsets.only(bottom: 7.w),
    );
  }

  @override
  void initState() {
    super.initState();
    languageController.getLanguages();

    isDevMode();
  }

  Future isDevMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDev = prefs.getBool('isDev');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCtrl>(
      init: ctrl,
      builder: (logic) {
        return PopScope(
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            Get.offAllNamed("/main-page");
          },
          child: Stack(
            children: [
              BackColor(),
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  // leading: BackArrow(),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.to(
                          //   () => ProfileEdit(),
                          // );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5.w, right: 5.w),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(25, 190, 190, 190),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: appController.user.value.avatar !=
                                            null
                                        ? Image.network(
                                            baseUrl +
                                                appController
                                                    .user.value.avatar!,
                                            height: 45.w,
                                            width: 45.w,
                                            fit: BoxFit.cover,
                                            // assets/images/avatar.png
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Container(
                                                height: 35.w,
                                                width: 35.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle),
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  'assets/images/avatar.png',
                                                  height: 35.w,
                                                  width: 35.w,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            'assets/images/avatar.png',
                                            height: 45.w,
                                            width: 45.w,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.visible,
                                          (appController.user.value.firstName ??
                                                  "N/A") +
                                              " ",
                                          // "Лувсанцэрэн  Пэрэнлэйжанцанлхагвадамба",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          overflow: TextOverflow.visible,
                                          (appController.user.value.lastName ??
                                              ""),
                                          // "Лувсанцэрэн  Пэрэнлэйжанцанлхагвадамба",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'ID: ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: appController.user.value.id
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13.sp),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(25, 190, 190, 190),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Container(
                              child: menuItem(
                                Icon(
                                  Mdi.menu,
                                  size: 20.w,
                                  color: mainWhite,
                                ),
                                'assets/icon-svg/icon/step_profile.svg',
                                'pp_huwiin_medeelel'.tr,
                                () => Get.to(
                                  () => ProfileEdit(),
                                ),
                              ),
                            ),
                            Divider(
                              color: grey,
                            ),
                            Container(
                              child: menuItem(
                                Icon(
                                  Mdi.informationOutline,
                                  size: 20.w,
                                  color: mainWhite,
                                ),
                                'assets/icon-svg/icon/step_profile.svg',
                                'pp_nevtreh_medeelel'.tr,
                                () => Get.to(
                                  () => LoginInfo(),
                                ),
                              ),
                            ),
                            Divider(
                              color: grey,
                            ),
                            Container(
                              child: menuItem(
                                Icon(
                                  Mdi.formTextboxPassword,
                                  size: 20.w,
                                  color: mainWhite,
                                ),
                                'assets/icon-svg/icon/step_profile.svg',
                                'l2_nuuts_vg'.tr,
                                () => Get.to(
                                  () => ChangePassword(),
                                ),
                              ),
                            ),
                            // Divider(
                            //   color: grey,
                            // ),
                            // Container(
                            //   child: menuItem(
                            //     Icon(
                            //       Icons.height_outlined,
                            //       size: 20.w,
                            //       color: mainWhite,
                            //     ),
                            //     'assets/icon-svg/icon/step_profile.svg',
                            //     'pp_undur'.tr,
                            //     () {
                            //       Get.to(() => BodyHeight());
                            //     },
                            //   ),
                            // ),
                            // Divider(
                            //   color: grey,
                            // ),
                            // Container(
                            //   child: menuItem(
                            //     Icon(
                            //       Icons.boy_rounded,
                            //       size: 20.w,
                            //       color: mainWhite,
                            //     ),
                            //     'assets/icon-svg/icon/step_profile.svg',
                            //     'pp_jin'.tr,
                            //     () {
                            //       Get.to(() => BodyWeight());
                            //     },
                            //   ),
                            // ),
                            // Divider(
                            //   color: grey,
                            // ),
                            // Container(
                            //   child: menuItem(
                            //     Icon(
                            //       Icons.directions_walk,
                            //       size: 20.w,
                            //       color: mainWhite,
                            //     ),
                            //     'assets/icon-svg/icon/step_profile.svg',
                            //     'pp_alhaltiin_urt'.tr,
                            //     () {
                            //       Get.to(() => StepLength());
                            //     },
                            //   ),
                            // ),
                            Divider(
                              color: grey,
                            ),
                            Container(
                              child: menuItem(
                                  Icon(
                                    Mdi.shoeSneaker,
                                    size: 20.w,
                                    color: mainWhite,
                                  ),
                                  'assets/icon-svg/icon/personal_profile.svg',
                                  'pp_odriin_alhalt_tohiruulah'.tr, () {
                                // setDailyGoalDialog(context);
                                dialogGoal(context);
                              }),
                            ),
                            Divider(
                              color: grey,
                            ),
                            Container(
                              child: menuItem(
                                  Icon(
                                    Mdi.accountMultipleOutline,
                                    size: 20.w,
                                    color: mainWhite,
                                  ),
                                  'assets/icon-svg/icon/invite_profile.svg',
                                  'pp_urisan_naiz'.tr, () {
                                Get.to(() => InviteFriend());
                              }),
                            ),
                          ],
                        ),
                      ),
                      badgeIsHidden == true
                          ? SizedBox()
                          : Column(
                              children: [
                                SizedBox(height: 7.h),
                                Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(25, 190, 190, 190),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: menuItem(
                                            Icon(
                                              Mdi.trophyAward,
                                              size: 20.w,
                                              color: mainWhite,
                                            ),
                                            'assets/icon-svg/icon/language-icon.svg',
                                            'Achievement'.tr, () {
                                          Get.to(() => AchievementPage());
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 7.h),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(25, 190, 190, 190),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Container(
                              child: menuItem(
                                  Icon(
                                    Mdi.translate,
                                    size: 20.w,
                                    color: mainWhite,
                                  ),
                                  'assets/icon-svg/icon/language-icon.svg',
                                  'pep_choose_lang'.tr, () {
                                languageController.setSelectedLang(
                                    languageController.currentLocale);
                                updateLanguage(context);
                              }),
                            ),
                            // Divider(
                            //   color: grey,
                            // ),
                            // Container(
                            //   child: menuItem(
                            //       Icon(
                            //         Mdi.bellCheckOutline,
                            //         size: 16.w,
                            //         color: mainWhite,
                            //       ),
                            //       'assets/icon-svg/icon/personal_profile.svg',
                            //       'pp_reminder'.tr, () {
                            //     // dialogGoal(context);
                            //   }),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(25, 190, 190, 190),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Container(
                              child: menuItem(
                                  Icon(
                                    Mdi.frequentlyAskedQuestions,
                                    size: 20.w,
                                    color: mainWhite,
                                  ),
                                  'assets/icon-svg/icon/language-icon.svg',
                                  'pep_instruction'.tr, () {
                                Get.to(() => WebViewContainer(
                                    link: selectedLocale1 == 'mn'
                                        ? '$faqLink'
                                        : selectedLocale1 == 'en'
                                            ? '$faqLinkEn'
                                            : '$faqLinkRu',
                                    name: 'pep_instruction'.tr));
                              }),
                            ),
                            feedbackLink == "https"
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Column(
                                    children: [
                                      Divider(
                                        color:
                                            Color.fromARGB(49, 185, 185, 185),
                                      ),
                                      Container(
                                        child: menuItem(
                                            Icon(
                                              Mdi.commentQuestion,
                                              size: 20.w,
                                              color: mainWhite,
                                            ),
                                            'assets/icon-svg/icon/personal_profile.svg',
                                            'pp_feedback'.tr, () {
                                          Get.to(() => WebViewContainer(
                                              link: selectedLocale1 == 'mn'
                                                  ? '$feedbackLink'
                                                  : selectedLocale1 == 'en'
                                                      ? '$feedbackLinkEn'
                                                      : '$feedbackLinkRu',
                                              name: 'pp_feedback'.tr));
                                        }),
                                      ),
                                    ],
                                  ),
                            policyLink == "https"
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Column(
                                    children: [
                                      Divider(
                                        color: grey,
                                      ),
                                      Container(
                                        child: menuItem(
                                            Icon(
                                              Mdi.policeBadgeOutline,
                                              size: 20.w,
                                              color: mainWhite,
                                            ),
                                            'assets/icon-svg/icon/personal_profile.svg',
                                            'pp_privacy'.tr, () {
                                          Get.to(() => WebViewContainer(
                                              link: selectedLocale1 == 'mn'
                                                  ? '$policyLink'
                                                  : selectedLocale1 == 'en'
                                                      ? '$policyLinkEn'
                                                      : '$policyLinkRu',
                                              name: 'pp_privacy'.tr));
                                        }),
                                      ),
                                    ],
                                  ),
                            Divider(
                              color: grey,
                            ),
                            InkWell(
                              // onTap: VoidCallbackAction,
                              onTap: () {
                                AppSettings.openAppSettings(
                                    type: AppSettingsType.location);
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: 10.h, bottom: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.settings,
                                          size: 20,
                                          color: white,
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          'pep_app_settings'.tr,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: mainWhite,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12.w,
                                      color: mainWhite.withOpacity(0.6),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: grey,
                            ),
                            InkWell(
                              // onTap: VoidCallbackAction,
                              onTap: (() {
                                Get.dialog(
                                  Container(
                                    child: AlertDialog(
                                      backgroundColor:
                                          HexColor('516469').withOpacity(0.8),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'pp_confirm_delete'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 23.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    color: Color(0xffffff)
                                                        .withOpacity(0.3)),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.5,
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      "pp_no".tr,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        const Color(0x627AF7)
                                                            .withOpacity(1),
                                                        const Color(0xEF566A)
                                                            .withOpacity(1),
                                                      ],
                                                      begin:
                                                          const FractionalOffset(
                                                              0.0, 0.0),
                                                      end:
                                                          const FractionalOffset(
                                                              1.0, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.5,
                                                child: TextButton(
                                                  onPressed: () async {
                                                    try {
                                                      String? token =
                                                          await fcm.getToken();
                                                      if (token != null) {
                                                        try {
                                                          await _netUtil.get(
                                                              '/api/fcm/remove/token/${appController.user.value.id}/$token');
                                                        } catch (e) {
                                                          FirebaseCrashlytics
                                                              .instance
                                                              .recordError(
                                                            Exception(e),
                                                            StackTrace
                                                                .current, // you should pass stackTrace in here
                                                            reason: e,
                                                            fatal: false,
                                                          );
                                                        }
                                                      }
                                                    } catch (e) {
                                                      print(
                                                          'logout eeeeerrrrr-----');
                                                      print(e);
                                                    }
                                                    agentController.logout();
                                                    appController.logout();
                                                    appController.setUser(null);
                                                    Get.offAllNamed("/login");
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      "pp_yes".tr,
                                                      style: TextStyle(
                                                        color: mainWhite,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: 10.h, bottom: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline_outlined,
                                          size: 20,
                                          color: white,
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          'delete_account'.tr,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: mainWhite,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12.w,
                                      color: mainWhite.withOpacity(0.6),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            isDev == true ||
                                    appController.user.value.showLog == 1
                                ? Column(
                                    children: [
                                      Divider(
                                        thickness: 2,
                                        color: redColor,
                                      ),
                                      Container(
                                        child: menuItem(
                                          Icon(
                                            Mdi.walk,
                                            size: 20.w,
                                            color: mainWhite,
                                          ),
                                          'assets/icon-svg/icon/step_profile.svg',
                                          'Step log',
                                          () => Get.to(
                                            () => StepLog(),
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(bottom: 7.w),
                                      //   child: menuItem(
                                      //       Icon(Mdi.stepBackward),
                                      //       'assets/icon-svg/icon/invite_profile.svg',
                                      //       'step log', () {
                                      //     Get.to(() => StepLog());
                                      //   }),
                                      // ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 0.h,
                                  ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          // Private information

                          // // Step history
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.transparent.withOpacity(0.2)),
                          //   margin: EdgeInsets.only(bottom: 7.w),
                          //   child: menuItem(
                          //       'assets/icon-svg/icon/history_outline.svg',
                          //       'pp_alhaltiin_tvvh'.tr, () {
                          //     Get.to(() => StepHistory());
                          //   }),
                          // ),

                          // My coupons
                          // Container(
                          //   margin: EdgeInsets.only(bottom: 7.w),
                          //   child: menuItem(
                          //       'assets/icon-svg/icon/coupon_profile.svg',
                          //       'pp_minii_cupon'.tr, () {
                          //     Get.to(() => MyCouponPage());
                          //   }),
                          // ),

                          // // Challenge
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.transparent.withOpacity(0.2)),
                          //   margin: EdgeInsets.only(bottom: 7.w),
                          //   child: menuItem(
                          //       'assets/icon-svg/icon/program_profile.svg',
                          //       'pp_hotolbor'.tr,
                          //       () => Get.to(() => ChallangeListPage())),
                          // ),

                          // invite friend

                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.transparent.withOpacity(0.2)),
                          //   margin: EdgeInsets.only(bottom: 7.w),
                          //   child: menuItem(
                          //       'assets/icon-svg/icon/support_profile.svg',
                          //       'Тусламж', () {
                          //     // inputPinCodeDialog(context, null);
                          //   }),
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.transparent.withOpacity(0.2)),
                          //   margin: EdgeInsets.only(bottom: 7.w),
                          //   child: menuItem('assets/icon-svg/icon/pin-code.svg',
                          //       'pp_pin_code_tohiruulah'.tr, () {
                          //     setPinCodeDialog(context);
                          //   }),
                          // ),

                          // Enter step goal

                          // Choose language

                          SizedBox(
                            height: 30.h,
                          ),
                          // logout button
                          GradientButtonSmall(
                            text: "pp_garah".tr,
                            color1: mainWhite.withOpacity(0.2),
                            color2: mainWhite.withOpacity(0.2),
                            textColor: mainWhite,
                            isShadow: false,
                            onPressed: () {
                              Get.dialog(
                                Container(
                                  child: AlertDialog(
                                    backgroundColor:
                                        HexColor('516469').withOpacity(0.8),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'pp_confirm'.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 14.h,
                                        ),
                                        Text(
                                          'pp_alert_desc'.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                        SizedBox(height: 32.h),
                                        TransparentButton(
                                          model: ButtonModel(
                                            icon: "",
                                            color1: ColorConstants.whiteColor,
                                            color2: ColorConstants.whiteColor,
                                            color3: ColorConstants.whiteColor,
                                            color4: ColorConstants.whiteColor,
                                            color5: ColorConstants.whiteColor
                                                .withOpacity(0.5),
                                            borderColor: Colors.white,
                                            text: "pp_confrm_log_out".tr,
                                            textStyle: TTextTheme
                                                .lightTextTheme.bodySmall,
                                            getTo: () async {
                                              try {
                                                String? token =
                                                    await fcm.getToken();
                                                if (token != null) {
                                                  try {
                                                    await _netUtil.get(
                                                        '/api/fcm/remove/token/${appController.user.value.id}/$token');
                                                  } catch (e) {
                                                    FirebaseCrashlytics.instance
                                                        .recordError(
                                                      Exception(e),
                                                      StackTrace
                                                          .current, // you should pass stackTrace in here
                                                      reason: e,
                                                      fatal: false,
                                                    );
                                                  }
                                                }
                                              } catch (e) {
                                                print('logout eeeeerrrrr-----');
                                                print(e);
                                              }
                                              agentController.logout();
                                              appController.logout();
                                              appController.setUser(null);
                                              Get.offAllNamed("/login");
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            versionCode,
                            style: TextStyle(color: grey, fontSize: 10),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget menuItem(icon, String iconPath, String title, VoidCallbackAction) {
    return InkWell(
      onTap: VoidCallbackAction,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          // padding: EdgeInsets.only(left: 20.w, top: 8.h, bottom: 8.h),
          // decoration: BoxDecoration(
          //     color: Colors.purple.shade800,
          //     // color: mainPurple,
          //     borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  // SvgPicture.asset(
                  //   width: 15.w,
                  //   iconPath,
                  //   fit: BoxFit.fill,
                  //   colorFilter: ColorFilter.mode(mainWhite, BlendMode.srcIn),
                  // ),
                  SizedBox(width: 15.w),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: mainWhite,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 13.w,
                color: mainWhite.withOpacity(0.6),
              )
            ],
          ),
        ),
      ),
    );
  }
}
