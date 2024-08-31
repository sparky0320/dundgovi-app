import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/challenge_controller.dart';
import 'package:move_to_earn/core/controllers/notification_controller.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/countdown_date.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/ui/component/headers/score_for_header.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_list_all.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_list_my.dart';
import 'package:nb_utils/nb_utils.dart';

class ChallangeListPage extends StatefulWidget {
  final bool showBack;

  const ChallangeListPage({super.key, this.showBack = true});

  @override
  State<ChallangeListPage> createState() => _ChallangeListPageState();
}

class _ChallangeListPageState extends State<ChallangeListPage>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;
  ChallengeController controller = Get.put(ChallengeController());
  NotificationController notificationController = Get.find();

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   controller.getChallenges();
    // });
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(appController.user.value.id);
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Scaffold(
            body: Stack(
              children: [
                BackColor(),
                Column(
                  children: [
                    widget.showBack
                        ? HeaderForPage(
                            text: "cp_hotolborvvd".tr,
                            backArrow: BackArrow(),
                          )
                        : Column(
                            children: [
                              ClipRRect(
                                child: BackdropFilter(
                                  filter: new ImageFilter.blur(
                                      sigmaX: 3.0, sigmaY: 3.0),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                            .viewPadding
                                            .top),
                                    margin: EdgeInsets.only(
                                        left: 20.w, right: 20.w, top: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'nav_challenge'.tr,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Nunito Sans'),
                                            ),
                                            ScoreForHeader(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: TabBar(
                        controller: tabBarController,
                        labelPadding: EdgeInsets.only(bottom: 0.h),
                        labelColor: whiteColor,
                        unselectedLabelColor: Colors.white.withOpacity(0.5),
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 0.1,
                        dividerColor: transparentColor,
                        // indicator: const UnderlineTabIndicator(
                        //     borderSide: BorderSide.none),
                        indicator: BoxDecoration(
                            color: grey.withOpacity(0.7),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                        // labelStyle: TextStyle(
                        //     fontFamily: GoogleFonts.nunito(
                        //   fontWeight: FontWeight.w500,
                        // ).fontFamily),
                        tabs: [
                          Tab(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    color: grey.withOpacity(0.15),
                                    border: Border(
                                        right: BorderSide(
                                            color: black, width: 0.1)),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      // topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        'gop_all'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >=
                                                  600
                                              ? 12.sp
                                              : 18.sp,
                                        ),
                                      ),
                                    ],
                                  ))),
                          Tab(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: grey.withOpacity(0.15),
                                border: Border(
                                    left: BorderSide(color: black, width: 0.1)),
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(15),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    'gop_my'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >=
                                                  600
                                              ? 12.sp
                                              : 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabBarController,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: ChallengeListAll(type: 'type'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: ChallengeListMy(type: 'type'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget AllTab() {
    return Container(
        // padding: EdgeInsets.only(top: viewTopSpaceSize.w),
        alignment: Alignment.topCenter,
        child: controller.loading
            ? Center(
                child: SpinKitRipple(
                  color: mainWhite,
                  size: 50.0.r,
                ),
              )
            : controller.challenges.isEmpty
                ? Center(
                    child: Text(
                    "cp_odoogoor_medeelel_bhgv_bn".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: mainWhite, fontSize: 18.sp),
                  ))
                : ListView(
                    padding: EdgeInsets.only(bottom: 120.h),
                    children: controller.challenges.map((e) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 12.h),
                        child: GestureDetector(
                          // onTap: () {
                          //   Get.to(() => ChallengeDetail(data: e));
                          // },
                          child: Container(
                            width: couponWidth.w,
                            height: 200.w,
                            child: Stack(
                              children: [
                                // Care point
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.r)),
                                  child: Image.network(
                                    baseUrl + e.thumb!,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.r)),
                                            color: Colors.black26),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "cp_unable_load_image".tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    },
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [],
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.transparent.withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15.w),
                                          bottomLeft: Radius.circular(15.w),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.w, horizontal: 20.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: 175.w,
                                                  child: Text(
                                                    '${e.score} ${'cp_care_onoonii_challenge'.tr}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )),
                                              CountDownDate(
                                                date: e.endDate!,
                                                fontSize: 8,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 1,
                                            height: 50.h,
                                            color: Colors.white,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: 45,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      child: CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                            'assets/images/avatar.png'),
                                                      ),
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 15,
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1,
                                                                ),
                                                                color: Colors
                                                                    .black),
                                                        child: Center(
                                                          child: Text(
                                                            NumberFormat()
                                                                .format(e
                                                                    .userCount!),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 8.w,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                'cp_orltsoj_bn'.tr,
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ));
  }
}
