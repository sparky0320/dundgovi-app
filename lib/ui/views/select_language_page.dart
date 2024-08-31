import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/translate/language_ctrl.dart';
import 'package:move_to_earn/ui/component/buttons/gradient_button_small.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeletons/skeletons.dart';

class SelectLanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectLanguagePage();
}

class _SelectLanguagePage extends State<SelectLanguagePage> {
  LanguageController ctrl = Get.find();

  @override
  void initState() {
    super.initState();
    getLanguages();
  }

  getLanguages() async {
    await ctrl.getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ctrl,
        builder: (logic) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: ColorConstants.backGradientColor1),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 44.w,
                      top: MediaQuery.of(context).viewPadding.top,
                      right: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'lang_choose_lang'.tr,
                            style: TextStyle(
                                color: mainWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 32.h, bottom: 0.h),
                            child: Skeleton(
                              isLoading: ctrl.langLoading,
                              skeleton: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      padding: EdgeInsets.only(
                                          left: 18.w,
                                          right: 18.w,
                                          top: 10.h,
                                          bottom: 10.h),
                                      margin: EdgeInsets.only(bottom: 14.h),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r)),
                                      ),
                                    ),
                                    Container(
                                      height: 40.h,
                                      padding: EdgeInsets.only(
                                          left: 18.w,
                                          right: 18.w,
                                          top: 10.h,
                                          bottom: 10.h),
                                      margin: EdgeInsets.only(bottom: 14.h),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r)),
                                      ),
                                    ),
                                    Container(
                                      height: 40.h,
                                      padding: EdgeInsets.only(
                                          left: 18.w,
                                          right: 18.w,
                                          top: 10.h,
                                          bottom: 10.h),
                                      margin: EdgeInsets.only(bottom: 14.h),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r)),
                                      ),
                                    )
                                  ]),
                              child: Column(
                                children: ctrl.langList.map((item) {
                                  return Container(
                                      padding: EdgeInsets.only(
                                          left: 18.w,
                                          right: 18.w,
                                          top: 10.h,
                                          bottom: 10.h),
                                      margin: EdgeInsets.only(bottom: 14.h),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.neutralColor5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r)),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            ctrl.selectedLang = item.id;
                                            ctrl.update();
                                            print('dsdksj========${item.code}');
                                            // selectedLocale = item.code!;
                                            ctrl.changeLocale(
                                                Locale(item.code!));
                                          });
                                        },
                                        child: Row(
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
                                                          Radius.circular(4.r)),
                                                  child: SvgPicture.network(
                                                    baseUrl + item.flag!,
                                                    width: 24.w,
                                                    height: 24.h,
                                                  ),
                                                ),
                                                SizedBox(width: 20.w),
                                                ctrl.selectedLang == item.id
                                                    ? Text(item.language!,
                                                        style: TextStyle(
                                                            color: mainWhite,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.sp))
                                                    : Text(item.language!,
                                                        style: TextStyle(
                                                            color:
                                                                mainGreyColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16.sp)),
                                              ],
                                            ),
                                            ctrl.selectedLang == item.id
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Colors.white,
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ));
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      GradientButtonSmall(
                        text: 'lang_choose_button'.tr,
                        color1: ColorConstants.buttonGradient2,
                        color2: ColorConstants.buttonGradient1,
                        isShadow: false,
                        textColor: whiteColor,
                        onPressed: () => Get.toNamed("/onboard"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
