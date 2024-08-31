import 'dart:ffi';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/coupon/coupon_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Daily extends StatefulWidget {
  Daily({Key? key}) : super(key: key);
  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  late List<String> value = [];
  CouponPageCtrl controller = Get.put(CouponPageCtrl());
  late bool isLoading = true;
  bool? isHavePin;
  bool isImageCached = false;
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  String? log;
  List? details;
  String? userBadgeName;
  int? userBadgeKilo;
  String? userBadgeImage;
  String? nextBadgeName;
  int? nextBadgeKilo;
  String? nextBadgeImage;
  int totalSteps = 0;

  final orientation = 200;

  @override
  void initState() {
    super.initState();
    GetUserBadge();
  }

  void GetUserBadge() {
    for (var item in appController.userStepLog) {
      totalSteps += item.stepCount ?? 0;
    }
    for (var badge in appController.badgesList) {
      if (appController.badgeUserList.isEmpty) {
        if (badge.id == 1) {
          setState(() {
            nextBadgeName = badge.name;
            nextBadgeKilo = badge.kilo;
            nextBadgeImage = badge.image;
          });
        }
      } else {
        for (var badgeUser in appController.badgeUserList) {
          if (badge.id == badgeUser.badgeid) {
            setState(() {
              userBadgeImage = badge.image;
              userBadgeName = badge.name;
              userBadgeKilo = badge.kilo;
            });
          }
          // Check if the current badge is the next badge
          if (badge.id == badgeUser.badgeid! + 1) {
            setState(() {
              nextBadgeName = badge.name;
              nextBadgeKilo = badge.kilo;
              nextBadgeImage = badge.image;
            });
          }
        }
      }

      // for (var badgeUser in appController.badgeUserList) {
      //   // Check if badgeUser.badgeid is null
      //   if (badgeUser == null) {
      //     if (badge.id == 1) {
      //       setState(() {
      //         nextBadgeName = badge.name;
      //         nextBadgeKilo = badge.kilo;
      //         nextBadgeImage = badge.image;
      //       });
      //     }
      //   } else {
      //     // Check if the current badge matches the user's badge
      //     if (badge.id == badgeUser.badgeid) {
      //       setState(() {
      //         userBadgeImage = badge.image;
      //         userBadgeName = badge.name;
      //         userBadgeKilo = badge.kilo;
      //       });
      //     }
      //     // Check if the current badge is the next badge
      //     if (badge.id == badgeUser.badgeid! + 1) {
      //       setState(() {
      //         nextBadgeName = badge.name;
      //         nextBadgeKilo = badge.kilo;
      //         nextBadgeImage = badge.image;
      //       });
      //     }
      //   }
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return getHistoryList();
  }

  Widget getHistoryList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.h, right: 20.h),
            child: Container(
              height: 220.w,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.transparent,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(100.r),
                        color: Colors.transparent,
                      ),
                      child: Obx(
                        () => CircularPercentIndicator(
                          radius: 110.0.w,
                          lineWidth: 18.0.w,
                          backgroundColor: Color(0xC8C8C8).withOpacity(0.5),
                          linearGradient: LinearGradient(
                            colors: [
                              HexColor("627AF7"),
                              HexColor("EF566A"),
                              HexColor("627AF7"),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          animation: true,
                          animationDuration: 1200,
                          animateFromLastPercent: true,
                          percent: Platform.isAndroid
                              ? appController.dailyGoal.value == 0 ||
                                      appController.stepCount.value >
                                          appController.dailyGoal.value
                                  ? 1.0
                                  : appController.stepCount.value /
                                      appController.dailyGoal.value
                              : appController.dailyGoal.value == 0 ||
                                      (appController.healthStep.value -
                                              appController.addedStepData) >
                                          appController.dailyGoal.value
                                  ? 1.0
                                  : (appController.healthStep.value -
                                          appController.addedStepData) /
                                      appController.dailyGoal.value,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: // Count the steps
                              Container(
                            alignment: Alignment.center,
                            child:
                                // Obx(
                                //   () {
                                // if (appController
                                //     .hasStepPermission.value) {
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                appController.stepLoading.value
                                    ? Center(child: CircularProgressIndicator())
                                    : Text(
                                        NumberFormat().format(Platform.isAndroid
                                            ? appController.stepCount.value
                                            : appController.healthStep.value -
                                                appController.addedStepData),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40.sp,
                                        ),
                                      ),
                                SizedBox(
                                  height: 6.w,
                                ),
                                Container(
                                  child: Text(
                                    'gop_onoodor'.tr,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.w),
                                  ),
                                ),
                                // SizedBox(height: 5.w),
                                Container(
                                    child: Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${'goal'.tr}: ${appController.dailyGoal.value} ",
                                        style: TextStyle(
                                          color: mainWhite,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.only(left: 20.h, right: 20.h),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 30,
                        lineWidth: 5.0.w,
                        backgroundColor: Color(0xC8C8C8).withOpacity(0.5),
                        linearGradient: LinearGradient(
                          colors: [
                            HexColor("627AF7"),
                            HexColor("EF566A"),
                            HexColor("627AF7"),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        animation: true,
                        animationDuration: 1200,
                        animateFromLastPercent: true,
                        percent: 1,
                        // percent: 0.8,

                        circularStrokeCap: CircularStrokeCap.round,

                        center: // Count the steps
                            Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Mdi.fire,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        Platform.isAndroid
                            ? (appController.stepCount.value *
                                        0.57 *
                                        int.parse(
                                            appController.user.value.weight!) /
                                        1000)
                                    .toStringAsFixed(1) +
                                ' cal'
                            : (appController.healthStep.value *
                                        0.57 *
                                        int.parse(
                                            appController.user.value.weight!) /
                                        1000)
                                    .toStringAsFixed(1) +
                                ' cal',
                        style: TextStyle(color: white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 30,
                        lineWidth: 5.0.w,
                        // arcType: ArcType.FULL_REVERSED,
                        // arcBackgroundColor:
                        //     HexColor("C8C8C8").withOpacity(0.3),
                        backgroundColor: Color(0xC8C8C8).withOpacity(0.5),
                        linearGradient: LinearGradient(
                          colors: [
                            HexColor("627AF7"),
                            HexColor("EF566A"),
                            HexColor("627AF7"),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        animation: true,
                        animationDuration: 1200,
                        animateFromLastPercent: true,
                        percent: 1,
                        // percent: 0.8,

                        circularStrokeCap: CircularStrokeCap.round,

                        center: // Count the steps
                            Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Mdi.walk,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        Platform.isAndroid
                            ? (appController.stepCount.value *
                                        0.4 *
                                        int.parse(
                                            appController.user.value.height!) /
                                        100 /
                                        1000)
                                    .toStringAsFixed(1) +
                                ' km'
                            : (appController.healthStep.value *
                                        0.4 *
                                        int.parse(
                                            appController.user.value.height!) /
                                        100 /
                                        1000)
                                    .toStringAsFixed(1) +
                                ' km',
                        style: TextStyle(color: white),
                      )
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     CircularPercentIndicator(
                  //       radius: 30,
                  //       lineWidth: 5.0.w,
                  //       // arcType: ArcType.FULL_REVERSED,
                  //       // arcBackgroundColor:
                  //       //     HexColor("C8C8C8").withOpacity(0.3),
                  //       backgroundColor: Color(0xC8C8C8).withOpacity(0.5),
                  //       linearGradient: LinearGradient(
                  //         colors: [
                  //           HexColor("627AF7"),
                  //           HexColor("EF566A"),
                  //           HexColor("627AF7"),
                  //         ],
                  //         begin: Alignment.bottomCenter,
                  //         end: Alignment.topCenter,
                  //       ),
                  //       animation: true,
                  //       animationDuration: 1200,
                  //       animateFromLastPercent: true,
                  //       percent: Platform.isAndroid
                  //           ? appController.dailyGoal.value == 0 ||
                  //                   appController.stepCount.value >
                  //                       appController.dailyGoal.value
                  //               ? 1.0
                  //               : appController.stepCount.value /
                  //                   appController.dailyGoal.value
                  //           : appController.dailyGoal.value == 0 ||
                  //                   (appController.healthStep.value -
                  //                           appController.addedStepData) >
                  //                       appController.dailyGoal.value
                  //               ? 1.0
                  //               : (appController.healthStep.value -
                  //                       appController.addedStepData) /
                  //                   appController.dailyGoal.value,
                  //       // percent: 0.8,

                  //       circularStrokeCap: CircularStrokeCap.round,

                  //       center: // Count the steps
                  //           Container(
                  //         alignment: Alignment.center,
                  //         child: Icon(
                  //           Mdi.watch,
                  //           color: white,
                  //           size: 30,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(height: 20.h),
                  //     Text('data')
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          badgeIsHidden == true
              ? SizedBox()
              : Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 2, // Thickness of the divider
                              margin: EdgeInsets.only(
                                  right: 10), // Space between divider and star
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.5),
                                    Colors.white
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Achievement',
                            style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Container(
                              height: 2, // Thickness of the divider
                              margin: EdgeInsets.only(
                                  left: 10), // Space between divider and star
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.5),
                                    Colors.transparent
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Stack(
                      children: [
                        Image.asset(
                          achievementBack,
                          height: 300.h,
                          width: MediaQuery.of(context).size.width,
                        ),
                        userBadgeImage == null
                            ? SizedBox()
                            : Positioned(
                                left: 55.h,
                                top: 50.h,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 65.h,
                                      height: 65.h,
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            "$baseUrl${userBadgeImage}",
                                            maxWidth: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    MediaQuery.of(context)
                                                        .devicePixelRatio)
                                                .round(),
                                          ),
                                          fit: BoxFit.fitHeight,
                                          filterQuality: FilterQuality.low,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      userBadgeName.toString(),
                                      style: TextStyle(color: white),
                                    ),
                                    Text(
                                      userBadgeKilo.toString() + ' км',
                                      style: TextStyle(color: white),
                                    ),
                                  ],
                                ),
                              ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2.3,
                          top: 10.h,
                          child: Column(
                            children: [
                              Icon(
                                Icons.man,
                                color: white,
                                size: 50,
                              ),
                              Text(
                                appController.user.value.firstName.toString() ==
                                            'null' ||
                                        appController.user.value.firstName
                                                .toString() ==
                                            null ||
                                        appController.user.value.firstName
                                                .toString() ==
                                            ''
                                    ? "You"
                                    : appController.user.value.firstName
                                        .toString(),
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '${((totalSteps * 76.2) / 100000).toStringAsFixed(2)} км',
                                style: TextStyle(color: white),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 55.h,
                          top: 50.h,
                          child: Column(
                            children: [
                              Container(
                                width: 65.h,
                                height: 65.h,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "$baseUrl${nextBadgeImage}",
                                      maxWidth:
                                          (MediaQuery.of(context).size.width *
                                                  MediaQuery.of(context)
                                                      .devicePixelRatio)
                                              .round(),
                                    ),
                                    fit: BoxFit.fitHeight,
                                    filterQuality: FilterQuality.low,
                                  ),
                                ),
                              ),
                              Text(
                                nextBadgeName.toString(),
                                style: TextStyle(color: white),
                              ),
                              Text(
                                nextBadgeKilo.toString() + ' км',
                                style: TextStyle(color: white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )

          // SizedBox(height: 10 ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10, left: 10),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 100.h,
          //     // decoration: BoxDecoration(color: Color),
          //     child: Row(
          //       children: [
          //         Icon(
          //           Mdi.trophy,
          //           color: gold,
          //           size: 40,
          //         ),
          //         Expanded(
          //           child: Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   '',
          //                   style: TextStyle(color: Colors.transparent),
          //                 ),
          //                 LinearProgressIndicator(
          //                   value: 0.6,
          //                   minHeight: 10,
          //                   backgroundColor: Colors.grey.withOpacity(0.4),
          //                   color: Colors.green,
          //                 ),
          //                 SizedBox(height: 5),
          //                 Text(
          //                   '1700км / 2000км',
          //                   style: TextStyle(color: white),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //         Icon(
          //           Mdi.trophy,
          //           color: black.withOpacity(0.5),
          //           size: 40,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
    // }
  }
}
