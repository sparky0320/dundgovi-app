import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';

void updateLanguage(ctx) {
  LanguageController ctrl = Get.find();
  showModalBottomSheet(
    context: ctx,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.grey[300],
    builder: (BuildContext context) {
      return GetBuilder<LanguageController>(
        init: ctrl,
        builder: (logic) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Skeleton(
              isLoading: ctrl.langLoading,
              skeleton: Column(children: [
                Container(
                  height: 40.h,
                  padding: EdgeInsets.only(
                      left: 18.w, right: 18.w, top: 10.h, bottom: 10.h),
                  margin: EdgeInsets.only(bottom: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                ),
                Container(
                  height: 40.h,
                  padding: EdgeInsets.only(
                      left: 18.w, right: 18.w, top: 10.h, bottom: 10.h),
                  margin: EdgeInsets.only(bottom: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                ),
                Container(
                  height: 40.h,
                  padding: EdgeInsets.only(
                      left: 18.w, right: 18.w, top: 10.h, bottom: 10.h),
                  margin: EdgeInsets.only(bottom: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                )
              ]),
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18.h),
                      Align(
                          alignment: Alignment.center,
                          child: Text('lang_choose_lang'.tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: mainBlack))),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 20.w),
                        child: Divider(color: mainGreyColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 46.w, top: 0.h, right: 46.w, bottom: 40.h),
                        child: Column(
                          children: ctrl.langList.map((item) {
                            return Column(
                              children: [
                                Ink(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                      color: Colors.transparent),
                                  child: InkWell(
                                    onTap: () async {
                                      ctrl.selectedLang = item.id;
                                      ctrl.update();
                                      ctrl.changeLocale(Locale(item.code!));
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'selectedLocale1', item.code!);
                                      Navigator.pop(context);
                                    },
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.r)),
                                                    child: SvgPicture.network(
                                                      baseUrl + item.flag!,
                                                      width: 24.w,
                                                      height: 24.h,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  Text(
                                                    item.language!,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: textBlack,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // item.id == 2
                                              ctrl.selectedLang == item.id
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color: Colors.purple[900],
                                                      size: 18.sp,
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
