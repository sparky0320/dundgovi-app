import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:move_to_earn/ui/views/profile/achievement/achievement_page.dart';
import 'package:move_to_earn/ui/views/steps/daily.dart';
import 'package:move_to_earn/ui/views/steps/monthly.dart';
import 'package:move_to_earn/ui/views/steps/weekly.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../core/constants/controllers.dart';

class StepHistory extends StatefulWidget {
  const StepHistory({super.key});

  @override
  State<StepHistory> createState() => _StepHistoryState();
}

class _StepHistoryState extends State<StepHistory>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;
  ScrollController scrollController = ScrollController();
  int historyPage = 0;
  bool historyEnd = false;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    // scrollController.addListener(scrollHandler);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appController.getNewStepHistory(reset: true);
      appController.getStep(reset: true);
      appController.getWeekStepHistory(reset: true);
    });
  }

  scrollHandler() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!historyEnd) {
        historyPage += 1;

        print("GET HISTORY");
        historyEnd = await appController.getStep();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          Container(
            padding: EdgeInsets.only(top: 48.h, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackArrow(),
                Text(
                  "shp_tvvh".tr,
                  style: TextStyle(
                      color: white, fontSize: 22, fontWeight: FontWeight.w700),
                ),
                badgeIsHidden == true
                    ? IconButton(
                        iconSize: 32,
                        icon: Icon(Icons.abc),
                        color: Colors.transparent,
                        onPressed: (() {}),
                      )
                    : IconButton(
                        iconSize: 32,
                        icon: Image.asset(
                          achievement,
                          height: careIconSize.w,
                          width: careIconSize.w,
                        ),
                        onPressed: () => Get.to(AchievementPage()),
                      ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100.h, left: 20.h, right: 20.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                    controller: tabBarController,
                    // labelPadding: EdgeInsets.only(
                    //   bottom: 7.h,
                    // ),
                    labelColor: whiteColor,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xEF566A).withOpacity(1),
                          Color(0x627AF7).withOpacity(1),
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    indicatorWeight: 0.1,
                    indicatorPadding: EdgeInsets.only(top: 42),

                    dividerColor: transparentColor,
                    // indicator: const UnderlineTabIndicator(
                    //     borderSide: BorderSide.none),
                    // indicator: BoxDecoration(
                    //     color: grey.withOpacity(0.7),
                    //     borderRadius: BorderRadius.all(Radius.circular(11))),
                    tabs: [
                      Tab(
                          child: Container(
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: transparentColor,
                                border: Border(
                                    right:
                                        BorderSide(color: black, width: 0.1)),
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
                                    'daily'.tr,
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
                              ))),
                      Tab(
                          child: Container(
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: transparentColor,
                                border: Border(
                                    right:
                                        BorderSide(color: black, width: 0.1)),
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
                                    'weekly'.tr,
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
                              ))),
                      Tab(
                          child: Container(
                        // width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: transparentColor,
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
                              'monthly'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width >= 600
                                        ? 12.sp
                                        : 18.sp,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabBarController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Daily(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Weekly(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Monthly(),
                    ),
                  ],
                ),
              )
            ],
          ),
          // Container(
          //   padding: EdgeInsets.only(top: 80.w),
          //   child: GetBuilder(
          //       init: appController,
          //       builder: (_) {
          //         return ListView(
          //           controller: scrollController,
          //           children: [
          //             appController.stepList.isEmpty
          //                 ? const SizedBox()
          //                 : ListView.builder(
          //                     physics: const NeverScrollableScrollPhysics(),
          //                     shrinkWrap: true,
          //                     itemCount: appController.stepList.length,
          //                     itemBuilder: (context, index) {
          //                       return Container(
          //                         margin: EdgeInsets.symmetric(
          //                           horizontal: 20.w,
          //                           vertical: 7.h,
          //                         ),
          //                         padding: EdgeInsets.symmetric(
          //                           horizontal: 20.w,
          //                           vertical: 15.h,
          //                         ),
          //                         decoration: BoxDecoration(
          //                           color: mainWhite.withOpacity(0.2),
          //                           borderRadius: BorderRadius.circular(12.w),
          //                         ),
          //                         child: Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             Container(
          //                               width: 150.w,
          //                               child: Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   SizedBox(
          //                                     child: Text(
          //                                       NumberFormat().format(
          //                                           appController
          //                                               .stepList[index].count),
          //                                       style: TextStyle(
          //                                           color: mainWhite,
          //                                           fontSize: 26.sp,
          //                                           fontWeight:
          //                                               FontWeight.w700),
          //                                     ),
          //                                   ),
          //                                   Text(
          //                                     'shp_alhalt'.tr,
          //                                     style: TextStyle(
          //                                         color: mainWhite,
          //                                         fontSize: 14.sp,
          //                                         fontWeight: FontWeight.w400),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             Text(
          //                               DateTime.parse(appController
          //                                           .stepList[index].date!)
          //                                       .month
          //                                       .toString() +
          //                                   " " +
          //                                   "shp_sarin".tr +
          //                                   " " +
          //                                   DateTime.parse(appController
          //                                           .stepList[index].date!)
          //                                       .day
          //                                       .toString(),
          //                               style: TextStyle(
          //                                   color: mainWhite,
          //                                   fontSize: 16.sp,
          //                                   fontWeight: FontWeight.w600),
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     },
          //                   ),
          //             appController.loading
          //                 ? Padding(
          //                     padding: EdgeInsets.only(top: 250.h),
          //                     child: Center(
          //                       child: LoadingCircle(),
          //                     ),
          //                   )
          //                 : appController.stepList.isEmpty
          //                     ? Center(
          //                         child: Text(
          //                           "shp_odoogoor_medeelel_bhgv_bn".tr,
          //                           textAlign: TextAlign.center,
          //                           style: TextStyle(
          //                               color: mainWhite, fontSize: 18),
          //                         ),
          //                       )
          //                     : const SizedBox()
          //           ],
          //         );
          //       }),
          // ),
        ],
      ),
    );
  }
}
