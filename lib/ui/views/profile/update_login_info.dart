import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/profile/profile_controller.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import 'package:nb_utils/nb_utils.dart';

void updatePhone(ctx) {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  showModalBottomSheet(
    context: ctx,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
    ),
    isScrollControlled: true,
    // backgroundColor: Colors.grey[300],
    backgroundColor: Color(0x556B73).withOpacity(1),
    builder: (BuildContext context) {
      // bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
      return GetBuilder<ProfileCtrl>(
        init: ctrl,
        builder: (logic) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.h, bottom: 40.h, left: 24.w, right: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'pep_dugaar_solih'.tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: white),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            maxLength: 8,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TTextTheme.darkTextTheme.bodySmall,
                            keyboardType: TextInputType.number,
                            controller: ctrl.phone,
                            onChanged: (val) {
                              ctrl.phoneLength = val.length;
                              ctrl.update();
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[300],
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.neutralColor3,
                                      width: 1.w),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r))),
                              counterText: "",
                              // counterStyle:
                              //     TTextTheme.darkTextTheme.headlineSmall,
                              contentPadding: EdgeInsets.all(12),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.neutralColor3,
                                      width: 1.w),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r))),
                              hintText: 'pep_shine_dugaar'.tr,
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: textBlack),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          GradientButtonSmall(
                            text: "pep_solih".tr,
                            color1: ColorConstants.buttonGradient2,
                            color2: ColorConstants.buttonGradient1,
                            isShadow: false,
                            textColor: whiteColor,
                            onPressed: () async {
                              if (ctrl.phoneLength == 0) {
                                Get.snackbar("", "",
                                    icon: Icon(Iconsax.warning_2,
                                        color: Colors.yellow, size: 32.sp),
                                    snackPosition: SnackPosition.TOP,
                                    titleText: Text(
                                      'Утасны дугаараа оруулна уу',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    messageText: Text(
                                      'Утасны дугаараа оруулснаар цааш үрэлжлүүлэх боломжтой',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 12.h));
                              } else if (ctrl.phoneLength < 8) {
                                Get.snackbar("", "",
                                    icon: Icon(Iconsax.warning_2,
                                        color: Colors.yellow, size: 32.sp),
                                    snackPosition: SnackPosition.TOP,
                                    titleText: Text(
                                      'Утасны дугаар буруу байна',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    messageText: Text(
                                      'Утасны дугаараа зөв оруулна уу',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 12.h));
                              } else {
                                ctrl.checkPhone(context);
                              }
                            },
                          ),
                          // SizedBox(
                          //   height: 42.h,
                          //   child: LoginSignUpButton(
                          //     model: ButtonModel(
                          //       color1: ColorConstants.buttonGradient2,
                          //       color2: ColorConstants.buttonGradient2,
                          //       color3: ColorConstants.buttonGradient1,
                          //       color4: ColorConstants.buttonGradient1,
                          //       color5: ColorConstants.buttonGradient1,
                          //       borderColor: Colors.transparent,
                          //       text: "pep_solih".tr,
                          //       icon: "",
                          //       textStyle: TTextTheme.lightTextTheme.bodySmall,
                          //       getTo: () {
                          //         if (ctrl.phoneLength == 0) {
                          //           Get.snackbar("", "",
                          //               icon: Icon(Iconsax.warning_2,
                          //                   color: Colors.yellow, size: 32.sp),
                          //               snackPosition: SnackPosition.TOP,
                          //               titleText: Text(
                          //                 'Утасны дугаараа оруулна уу',
                          //                 style: TextStyle(
                          //                     color: Colors.black,
                          //                     fontSize: 16.sp,
                          //                     fontWeight: FontWeight.w500),
                          //               ),
                          //               messageText: Text(
                          //                 'Утасны дугаараа оруулснаар цааш үрэлжлүүлэх боломжтой',
                          //                 style: TextStyle(
                          //                     color: Colors.grey,
                          //                     fontSize: 12.sp),
                          //               ),
                          //               backgroundColor: Colors.white,
                          //               padding: EdgeInsets.symmetric(
                          //                   horizontal: 16.w, vertical: 12.h));
                          //         } else if (ctrl.phoneLength < 8) {
                          //           Get.snackbar("", "",
                          //               icon: Icon(Iconsax.warning_2,
                          //                   color: Colors.yellow, size: 32.sp),
                          //               snackPosition: SnackPosition.TOP,
                          //               titleText: Text(
                          //                 'Утасны дугаар буруу байна',
                          //                 style: TextStyle(
                          //                     color: Colors.black,
                          //                     fontSize: 16.sp,
                          //                     fontWeight: FontWeight.w500),
                          //               ),
                          //               messageText: Text(
                          //                 'Утасны дугаараа зөв оруулна уу',
                          //                 style: TextStyle(
                          //                     color: Colors.grey,
                          //                     fontSize: 12.sp),
                          //               ),
                          //               backgroundColor: Colors.white,
                          //               padding: EdgeInsets.symmetric(
                          //                   horizontal: 16.w, vertical: 12.h));
                          //         } else {
                          //           ctrl.checkPhone(context);
                          //         }
                          //       },
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void updateEmail(ctx) {
  ProfileCtrl ctrl = Get.put(ProfileCtrl());
  showModalBottomSheet(
    context: ctx,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
    ),
    isScrollControlled: true,
    // backgroundColor: Colors.grey[300],
    backgroundColor: Color(0x556B73).withOpacity(1),
    builder: (BuildContext context) {
      // bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
      return GetBuilder<ProfileCtrl>(
        init: ctrl,
        builder: (logic) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.h, bottom: 40.h, left: 24.w, right: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'pep_email_solih'.tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: white),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TTextTheme.darkTextTheme.bodySmall,
                            keyboardType: TextInputType.emailAddress,
                            controller: ctrl.email,
                            onChanged: (val) {
                              ctrl.emailLength = val.length;
                              ctrl.update();
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[300],
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.neutralColor3,
                                      width: 1.w),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r))),
                              counterText: "",
                              // counterStyle:
                              //     TTextTheme.darkTextTheme.headlineSmall,
                              contentPadding: EdgeInsets.all(12),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.neutralColor3,
                                      width: 1.w),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r))),
                              hintText: 'pep_new_email'.tr,
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: textBlack),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          GradientButtonSmall(
                            text: "pep_solih".tr,
                            color1: ColorConstants.buttonGradient2,
                            color2: ColorConstants.buttonGradient1,
                            isShadow: false,
                            textColor: whiteColor,
                            onPressed: () async {
                              if (ctrl.emailLength == 0) {
                                Get.snackbar("", "",
                                    icon: Icon(Iconsax.warning_2,
                                        color: Colors.yellow, size: 32.sp),
                                    snackPosition: SnackPosition.TOP,
                                    titleText: Text(
                                      'Имэйл хаягаа оруулна уу',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    messageText: Text(
                                      'Имэйл хаягаа оруулснаар цааш үрэлжлүүлэх боломжтой',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 12.h));
                              } else {
                                // else if (ctrl.phoneLength < 8) {
                                //   Get.snackbar("", "",
                                //       icon: Icon(Iconsax.warning_2,
                                //           color: Colors.yellow, size: 32.sp),
                                //       snackPosition: SnackPosition.TOP,
                                //       titleText: Text(
                                //         'Утасны дугаар буруу байна',
                                //         style: TextStyle(
                                //             color: Colors.black,
                                //             fontSize: 16.sp,
                                //             fontWeight: FontWeight.w500),
                                //       ),
                                //       messageText: Text(
                                //         'Утасны дугаараа зөв оруулна уу',
                                //         style: TextStyle(
                                //             color: Colors.grey, fontSize: 12.sp),
                                //       ),
                                //       backgroundColor: Colors.white,
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: 16.w, vertical: 12.h));
                                // } else {
                                ctrl.checkEmail(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
