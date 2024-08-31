import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/views/home/score_log_page.dart';

class ScoreHeader extends StatefulWidget {
  const ScoreHeader({super.key});

  @override
  State<ScoreHeader> createState() => _ScoreHeaderState();
}

class _ScoreHeaderState extends State<ScoreHeader> {
  AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              margin: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackArrow(),
                  Center(
                    child: hideForIos
                        ? Text("")
                        : Material(
                            color: Colors.transparent,
                            child: Ink(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ScoreLogPage());
                                },
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.r)),
                                child: Padding(
                                  padding: EdgeInsets.all(4.r),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        newcoin,
                                        height: careIconSize.w,
                                        width: careIconSize.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 6.w, right: 6.w),
                                        child: Obx(
                                          () => RichText(
                                            text: TextSpan(
                                              text: NumberFormat().format(
                                                  appController.point.value
                                                      .round()),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 30.w,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
