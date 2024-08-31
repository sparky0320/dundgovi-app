import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lambda/plugins/bottom_modal/bottom_modal.dart';
import 'package:move_to_earn/core/controllers/authentication/get_info_controller.dart';
import 'package:move_to_earn/ui/views/signup/info_screen.dart';
import 'package:move_to_earn/ui/views/signup/select_address_screen.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/util.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/ui/views/profile/pick_image.dart';
import 'package:move_to_earn/ui/views/profile/update_gender.dart';
import '../../../core/constants/colors.dart';
import '../../../core/models/model_button.dart';
import '../../../utils/theme/widget_theme/text_theme.dart';
import '../../component/buttons/gradient_button_old.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  LanguageController languageController = Get.find();
  GetInfoController getInfoCtrl = Get.put(GetInfoController());
  PageController pageController = new PageController();

  // SharedPreferences? _prefs;
  int weightKG = 50;
  int? _weightInitialItem = 30;

  int cmHeight = 170;
  int? _heightInitialItem = 120;

  List<dynamic> _sumDuureg = [];
  String? selectedAimag;
  // String? selectedSum;
  bool isAimagSelected = false;

  @override
  void initState() {
    if (appController.user.value.firstName != null) {
      ctrl.firstName.text = appController.user.value.firstName!;
    }
    if (appController.user.value.lastName != null) {
      ctrl.lastName.text = appController.user.value.lastName!;
    }
    if (appController.user.value.phone != null) {
      ctrl.phoneNumberView = appController.user.value.phone!;
    }
    if (appController.user.value.birthday != null) {
      ctrl.selectedDate = appController.user.value.birthday!;
    } else {
      ctrl.selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    }
    if (appController.user.value.gender != null) {
      ctrl.selectedGender = appController.user.value.gender!;
    }
    if (appController.user.value.email != null) {
      ctrl.email.text = appController.user.value.email!;
    }
    if (appController.user.value.aimagHot != "") {
      ctrl.aimagHot = appController.user.value.aimagHot!;
    }
    if (appController.user.value.sumDuureg != "") {
      ctrl.sumDuureg = appController.user.value.sumDuureg!;
    }

    if (appController.user.value.weight != null) {
      weightKG = int.parse(appController.user.value.weight!);
      _weightInitialItem = int.parse(appController.user.value.weight!) - 20;
    }

    if (appController.user.value.height != null) {
      cmHeight = int.parse(appController.user.value.height!);
      _heightInitialItem = int.parse(appController.user.value.height!) - 50;
    }

    ctrl.height = cmHeight.toString();
    ctrl.weight = weightKG.toString();

    getInfoCtrl.getAimagList();
    getInfoCtrl.getSumDuuregList();
    checkAimag();
    super.initState();
  }

  Future<void> checkAimag() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (getInfoCtrl.aimagHot == null) {
      setState(() {
        selectedAimag = getInfoCtrl.aimagList[0].name;
        for (var i = 0; i < getInfoCtrl.sumDuuregList.length; i++) {
          if (getInfoCtrl.sumDuuregList[i].aimagId == 1) {
            _sumDuureg.add(getInfoCtrl.sumDuuregList[i]);
            getInfoCtrl.sumDuureg = _sumDuureg[0].name;
          }
        }
      });
    }
  }

  Widget menuItem(icon, String iconPath, String title, VoidCallbackAction) {
    return InkWell(
      onTap: VoidCallbackAction,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          padding:
              EdgeInsets.only(top: 8.h, right: 12.w, left: 12.w, bottom: 8.h),
          decoration: BoxDecoration(
            color: mainWhite.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(4.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  weightSelector(double fullHeight) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: fullHeight * 0.025),
                child: Image.asset(
                  "assets/icon-png/ic_select_pointer.png",
                  color: mainWhite.withOpacity(0.8),
                ),
              ),
            ),
            Container(
              width: 125.w,
              height: fullHeight * 0.32,
              child: CupertinoPicker(
                useMagnifier: true,
                magnification: 1.05,
                selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                  background: Colors.transparent,
                ),
                looping: false,
                scrollController: FixedExtentScrollController(
                    initialItem: _weightInitialItem!),
                onSelectedItemChanged: (value) {
                  setState(() {
                    value += 20;
                    weightKG = value;
                    ctrl.weight = weightKG.toString();
                    ctrl.update();
                    print(ctrl.weight);
                  });
                },
                itemExtent: 75.0,
                children: List.generate(150, (index) {
                  index += 20;
                  return Text(
                    "$index",
                    style: TextStyle(
                      color: mainWhite,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: fullHeight * 0.025),
                child: Text(
                  "kg",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _heightSelector(double fullHeight) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: fullHeight * 0.025),
              child: Image.asset(
                "assets/icon-png/ic_select_pointer.png",
                color: mainWhite.withOpacity(0.8),
              ),
            ),
          ),
          Container(
            width: 125.w,
            height: 300.h,
            child: CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: _heightInitialItem!),
              useMagnifier: true,
              magnification: 1.05,
              looping: false,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: Colors.transparent,
              ),
              onSelectedItemChanged: (value) {
                setState(() {
                  value += 50;
                  cmHeight = value;
                  ctrl.height = cmHeight.toString();
                  ctrl.update();
                  print(ctrl.height);
                });
              },
              itemExtent: 75.0,
              children: List.generate(191, (index) {
                index += 50;
                return Text(
                  "$index",
                  style: TextStyle(
                      color: mainWhite,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold),
                );
              }),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: fullHeight * 0.025),
              child: Text(
                "cm",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _changeSumDuureg(int val) {

  //       for (var i = 0; i < getInfoCtrl.aimagList.length; i++) {
  //         if (getInfoCtrl.aimagList[i].id == val + 1) {
  //           selectedAimag = getInfoCtrl.aimagList[i].name;
  //         }
  //       }
  //       // selectedAimagId = val - 1;
  //       _sumDuureg = [];
  //       for (var i = 0; i < getInfoCtrl.sumDuuregList.length; i++) {
  //         if (getInfoCtrl.sumDuuregList[i].aimagId == val + 1) {
  //           _sumDuureg.add(getInfoCtrl.sumDuuregList[i]);
  //           selectedSum = _sumDuureg[0].name;
  //         }
  //       }

  // }

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
                ),
                body: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: ClipOval(
                            child: appController.user.value.avatar != null
                                ? Image.network(
                                    baseUrl + appController.user.value.avatar!,
                                    height: proHeight.w,
                                    width: proWidth.w,
                                    fit: BoxFit.cover,
                                    // assets/images/avatar.png
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        height: proHeight.w,
                                        width: proWidth.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/avatar.png',
                                          height: proHeight.w,
                                          width: proWidth.w,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/images/avatar.png',
                                    height: 120.h,
                                    width: 120.w,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.w,
                          left: 0,
                          right: -100.w,
                          child: InkWell(
                            onTap: () {
                              print('edit avatar ---');
                              showPickImageModal(context, () {
                                ctrl.getImage('camera', context);
                                Navigator.pop(context);
                              }, () {
                                ctrl.getImage('gallery', context);
                                Navigator.pop(context);
                              });
                            },
                            borderRadius: BorderRadius.circular(50.r),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(8.r),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.purple[900],
                                size: 20.sp,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              (appController.user.value.firstName ?? "N/A") +
                                  " " +
                                  (appController.user.value.lastName ?? ""),
                              style: TextStyle(
                                  fontSize: 22.sp, color: Colors.white),
                            ),
                            Text(
                              'pep_biye_bodooroi'.tr,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Util.fromHex("#A5A5A5")),
                            ),
                            SizedBox(height: 28.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'pep_huwiin_medeelel'.tr,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ),
                                  Form(
                                    key: ctrl.profileFormKey,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 12.h),
                                        Container(
                                          child: TextFormField(
                                            cursorColor: mainBlack,
                                            style: TextStyle(
                                                color: mainWhite,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp),
                                            controller: ctrl.lastName,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: InputDecoration(
                                              prefixIcon: null,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 12.w,
                                                  bottom: 8.h,
                                                  top: 8.h),
                                              fillColor:
                                                  mainWhite.withOpacity(0.2),
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              hintText: "pep_owog".tr,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.w,
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.w,
                                                    color: Colors.red),
                                              ),
                                              errorStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: mainRed),
                                            ),
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'Хоосон талбар байна.';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(height: buttonSpaceSize.h),
                                        Container(
                                          child: TextFormField(
                                            cursorColor: mainBlack,
                                            style: TextStyle(
                                                color: mainWhite,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp),
                                            controller: ctrl.firstName,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: InputDecoration(
                                              prefixIcon: null,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 12.w,
                                                  bottom: 8.h,
                                                  top: 8.h),
                                              fillColor:
                                                  mainWhite.withOpacity(0.2),
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              hintText: "pep_ner".tr,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.w,
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.w,
                                                    color: Colors.red),
                                              ),
                                              errorStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: mainRed),
                                            ),
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'Хоосон талбар байна.';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(height: buttonSpaceSize.h),
                                        // InkWell(
                                        //   onTap: () async {
                                        //     ctrl.phone.clear();
                                        //     updatePhone(context);
                                        //   },
                                        //   child: Container(
                                        //     // height: 60.h,
                                        //     width: double.infinity,
                                        //     padding: EdgeInsets.only(
                                        //         top: 8.h,
                                        //         right: 12.w,
                                        //         left: 12.w,
                                        //         bottom: 8.h),
                                        //     decoration: BoxDecoration(
                                        //       color: mainWhite.withOpacity(0.2),
                                        //       borderRadius: BorderRadius.all(
                                        //         Radius.circular(4.r),
                                        //       ),
                                        //     ),
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment
                                        //               .spaceBetween,
                                        //       children: [
                                        //         Text(
                                        //           ctrl.phoneNumberView ??
                                        //               'pep_utasnii_dugaar'.tr,
                                        //           style: TextStyle(
                                        //             fontSize: 14.sp,
                                        //             fontWeight: FontWeight.w400,
                                        //             color: Colors.white,
                                        //           ),
                                        //         ),
                                        //         // Icon(
                                        //         //   Icons
                                        //         //       .keyboard_arrow_down_rounded,
                                        //         //   color: mainWhite,
                                        //         // ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(height: buttonSpaceSize.h),
                                        InkWell(
                                          onTap: () async {
                                            // DateTime? pickedDate =
                                            //     await showDatePicker(
                                            //   context: context,
                                            //   locale: languageController
                                            //       .currentLocale,
                                            //   initialDate: DateTime.parse(
                                            //     appController.user.value
                                            //                 .birthday !=
                                            //             null
                                            //         ? appController
                                            //             .user.value.birthday!
                                            //         : DateTime.now().toString(),
                                            //   ),
                                            //   //get today's date
                                            //   firstDate: DateTime(1910),
                                            //   //DateTime.now() - not to allow to choose before today.
                                            //   lastDate: DateTime.now(),
                                            // );
                                            // if (pickedDate != null) {
                                            //   String formattedDate =
                                            //       DateFormat("yyyy-MM-dd")
                                            //           .format(pickedDate);
                                            //   ctrl.selectedDate =
                                            //       formattedDate.toString();
                                            //   ctrl.update();
                                            // } else {
                                            //   print("selected date");
                                            // }

                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 400,
                                                  child: Stack(
                                                    children: [
                                                      BackColor(),
                                                      CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          brightness:
                                                              Brightness.dark,
                                                        ),
                                                        child:
                                                            CupertinoDatePicker(
                                                          itemExtent: 50,
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          initialDateTime: DateFormat(
                                                                  "yyyy-MM-dd")
                                                              .parse(ctrl
                                                                  .selectedDate!),
                                                          onDateTimeChanged:
                                                              (DateTime
                                                                  newDateTime) {
                                                            setState(() {
                                                              ctrl.selectedDate =
                                                                  DateFormat(
                                                                          "yyyy-MM-dd")
                                                                      .format(
                                                                          newDateTime);
                                                              appController
                                                                  .user
                                                                  .value
                                                                  .birthday = DateFormat(
                                                                      "yyyy-MM-dd")
                                                                  .format(
                                                                      newDateTime);
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  ctrl.selectedDate ??
                                                      'pep_torson_ognoo'.tr,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: Colors.white),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ctrl.selectedDate == null ||
                                                ctrl.selectedDate == ''
                                            ? Text(
                                                'Хоосон талбар байна.',
                                                style: TextStyle(
                                                    color: mainRed,
                                                    fontSize: 12.sp),
                                              )
                                            : SizedBox(),
                                        SizedBox(height: buttonSpaceSize.h),
                                        InkWell(
                                          onTap: () {
                                            updateGender(context);
                                          },
                                          child: Container(
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
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Text(
                                                //   'pep_hvis'.tr,
                                                //   style: TextStyle(fontSize: 10.sp, color: Util.fromHex("#A5A5A5")),
                                                // ),
                                                // SizedBox(height: 4.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      ctrl.selectedGender == 'm'
                                                          ? 'pep_eregtei'.tr
                                                          : 'pep_emegtei'.tr,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Container(
                                        //   child: TextFormField(
                                        //     enabled: false,
                                        //     cursorColor: mainBlack,
                                        //     style: TextStyle(
                                        //         color: mainWhite,
                                        //         fontWeight: FontWeight.w400,
                                        //         fontSize: 14.sp),
                                        //     controller: ctrl.email,
                                        //     keyboardType: TextInputType.text,
                                        //     textInputAction:
                                        //         TextInputAction.next,
                                        //     autovalidateMode: AutovalidateMode
                                        //         .onUserInteraction,
                                        //     decoration: InputDecoration(
                                        //       prefixIcon: null,
                                        //       isDense: true,
                                        //       contentPadding: EdgeInsets.only(
                                        //           left: 12.w,
                                        //           bottom: 8.h,
                                        //           top: 8.h),
                                        //       fillColor:
                                        //           mainWhite.withOpacity(0.2),
                                        //       filled: true,
                                        //       enabledBorder: OutlineInputBorder(
                                        //           borderSide: const BorderSide(
                                        //               color: Colors
                                        //                   .transparent),
                                        //           borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(
                                        //                       4.r))),
                                        //       hintText: "pep_email_hayg".tr,
                                        //       hintStyle: TextStyle(
                                        //           color: Colors.grey.shade400,
                                        //           fontSize: 14.sp,
                                        //           fontWeight: FontWeight.w400),
                                        //       focusedBorder: OutlineInputBorder(
                                        //         borderSide: const BorderSide(
                                        //             color: Colors.transparent),
                                        //       ),
                                        //       errorBorder: OutlineInputBorder(
                                        //           borderSide: BorderSide(
                                        //               width: 0.w,
                                        //               color: Colors.red),
                                        //           borderRadius:
                                        //               BorderRadius.all(
                                        //                   Radius.circular(
                                        //                       4.r))),
                                        //       focusedErrorBorder:
                                        //           OutlineInputBorder(
                                        //               borderSide: BorderSide(
                                        //                   width: 0.w,
                                        //                   color: Colors.red),
                                        //               borderRadius:
                                        //                   BorderRadius.all(
                                        //                       Radius.circular(
                                        //                           4.r))),
                                        //       errorStyle: TextStyle(
                                        //           fontSize: 12.sp,
                                        //           color: mainRed),
                                        //     ),
                                        //     validator: (val) {
                                        //       if (val == null || val.isEmpty) {
                                        //         return 'Хоосон талбар байна.';
                                        //       } else {
                                        //         return null;
                                        //       }
                                        //     },
                                        //   ),
                                        // ),
                                        Container(
                                          child: menuItem(
                                            Icon(
                                              Icons.height_outlined,
                                              size: 20.w,
                                              color: mainWhite,
                                            ),
                                            'assets/icon-svg/icon/step_profile.svg',
                                            "${cmHeight} cm",
                                            () {
                                              // Get.to(() => BodyHeight());
                                              showBottomModal(
                                                context: context,
                                                dismissOnTap: false,
                                                builder: (context) {
                                                  var fullHeight =
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          2;
                                                  var fullWidth =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;

                                                  return Container(
                                                    height: 400,
                                                    child: Stack(
                                                      children: [
                                                        BackColor(),
                                                        Container(
                                                          height: fullHeight,
                                                          width: fullWidth,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: 48.h,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    IconButton(
                                                                      iconSize:
                                                                          32,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .chevron_left,
                                                                        color:
                                                                            mainWhite,
                                                                      ),
                                                                      onPressed:
                                                                          () =>
                                                                              Get.back(),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        "pp_undur_hed_we"
                                                                            .tr,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              22.sp,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          decoration:
                                                                              TextDecoration.none,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              _heightSelector(
                                                                  fullHeight),
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom:
                                                                      fullHeight *
                                                                          0.08,
                                                                ),
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child:
                                                                    GradientButtonSmall(
                                                                  text:
                                                                      'rp_vrgeljlvvleh'
                                                                          .tr,
                                                                  isShadow:
                                                                      false,
                                                                  color1: ColorConstants
                                                                      .buttonGradient2,
                                                                  color2: ColorConstants
                                                                      .buttonGradient1,
                                                                  textColor:
                                                                      mainWhite,
                                                                  onPressed:
                                                                      () {
                                                                    // widget.ctrl!.height = cmHeight.toString();
                                                                    Navigator.pop(
                                                                        context);
                                                                    // ctrl.editHeight(
                                                                    //     context);
                                                                    // var _prefs = await SharedPreferences.getInstance();
                                                                    // _prefs.setInt('body_height', cmHeight!);
                                                                    // print(_prefs.getInt('body_height'));
                                                                    // Get.back();
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: menuItem(
                                            Icon(
                                              Icons.boy_rounded,
                                              size: 20.w,
                                              color: mainWhite,
                                            ),
                                            'assets/icon-svg/icon/step_profile.svg',
                                            "${weightKG} kg",
                                            () {
                                              // Get.to(() => BodyWeight());
                                              showBottomModal(
                                                context: context,
                                                dismissOnTap: false,
                                                builder: (context) {
                                                  var fullHeight =
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          2;
                                                  var fullWidth =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;

                                                  return Container(
                                                    height: 500,
                                                    child: Stack(
                                                      children: [
                                                        BackColor(),
                                                        Container(
                                                          height: fullHeight,
                                                          width: fullWidth,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: 48.h,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    IconButton(
                                                                        iconSize:
                                                                            32,
                                                                        icon: Icon(
                                                                            Icons
                                                                                .chevron_left,
                                                                            color:
                                                                                mainWhite),
                                                                        onPressed:
                                                                            () =>
                                                                                Get.back()),
                                                                    SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        "pp_jin_hed_we"
                                                                            .tr,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              22.sp,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          decoration:
                                                                              TextDecoration.none,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              weightSelector(
                                                                  fullHeight),
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom:
                                                                      fullHeight *
                                                                          0.08,
                                                                ),
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child:
                                                                    GradientButtonSmall(
                                                                  isShadow:
                                                                      false,
                                                                  text:
                                                                      'rp_vrgeljlvvleh'
                                                                          .tr,
                                                                  textColor:
                                                                      mainWhite,
                                                                  color1: ColorConstants
                                                                      .buttonGradient2,
                                                                  color2: ColorConstants
                                                                      .buttonGradient1,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  //   () async {
                                                                  // ctrl.editWeight(
                                                                  //     context);

                                                                  // var _prefs = await SharedPreferences.getInstance();
                                                                  // _prefs.setInt('body_weight', weightKG!);
                                                                  // print(_prefs.getInt('body_weight'));
                                                                  // Get.back();
                                                                  // },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),

                                        Container(
                                          child: menuItem(
                                            Icon(
                                              Icons.boy_rounded,
                                              size: 20.w,
                                              color: mainWhite,
                                            ),
                                            'assets/icon-svg/icon/step_profile.svg',
                                            ctrl.aimagHot == "" ||
                                                    ctrl.sumDuureg == ""
                                                ? "Оршин суугаа хаяг?"
                                                : "${ctrl.aimagHot} ${ctrl.sumDuureg}",
                                            () {
                                              Get.to(() => SelectAddress(
                                                        ctrl: getInfoCtrl,
                                                        infoScreenState:
                                                            InfoScreenState(),
                                                        isEdit: true,
                                                        isBack: true,
                                                      ))!
                                                  .then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    getInfoCtrl.aimagHot =
                                                        value["aimag"];
                                                    getInfoCtrl.sumDuureg =
                                                        value["sum"];
                                                    appController.user.value
                                                            .aimagHot =
                                                        getInfoCtrl.aimagHot;
                                                    appController.user.value
                                                            .sumDuureg =
                                                        getInfoCtrl.sumDuureg;
                                                    ctrl.aimagHot =
                                                        value["aimag"];
                                                    ctrl.sumDuureg =
                                                        value["sum"];
                                                  });
                                                  print("object");
                                                  ;
                                                }
                                              });
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
                            final form = ctrl.profileFormKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              ctrl.changeUserData(context);
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
