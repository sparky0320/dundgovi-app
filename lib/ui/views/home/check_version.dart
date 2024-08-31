// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckVersion extends StatefulWidget {
  const CheckVersion({super.key});

  @override
  State<CheckVersion> createState() => _CheckVersion();
}

class _CheckVersion extends State<CheckVersion> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width > 500 ? 100.h : 80.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        // color: mainPurple.withOpacity(0.3),
        gradient: LinearGradient(
          colors: [
            Color(0x0E1C26).withOpacity(1),
            Color(0x2A454B).withOpacity(1),
            Color(0x294861).withOpacity(1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.rocket,
            color: white,
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'update_text1'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'update_text2'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          InkWell(
            onTap: () => launch(applink),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                gradient: LinearGradient(
                  colors: [
                    ColorConstants.buttonGradient2,
                    ColorConstants.buttonGradient1,
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.file_download,
                    color: white,
                    size: 20,
                  ),
                  Text(
                    "update".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
