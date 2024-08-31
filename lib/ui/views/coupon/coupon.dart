import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/views/coupon/coupon_list_my.dart';
import 'package:move_to_earn/ui/component/headers/score_for_header.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../core/controllers/coupon/coupon_controller.dart';
import 'coupon_list.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;

  CouponPageCtrl controller = Get.put(CouponPageCtrl());

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
    // controller.getCouponByCategory();
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponPageCtrl>(
        init: controller,
        builder: (logic) {
          return Scaffold(
            body: Stack(
              children: [
                BackColor(),
                Column(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          child: BackdropFilter(
                            filter:
                                new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).viewPadding.top),
                              margin: EdgeInsets.only(
                                  left: 20.w, right: 20.w, top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'cp_title'.tr,
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Nunito Sans',
                                            letterSpacing: -0.5),
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
                        labelPadding: EdgeInsets.only(
                          bottom: 0.h,
                        ),
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
                    Expanded(
                      child: TabBarView(
                        controller: tabBarController,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: CouponListAll(type: 'type'),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: CouponListMy(type: 'type'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // ClipRRect(
                //   child: BackdropFilter(
                //     filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                //     child: Container(
                //       padding: EdgeInsets.only(
                //           top: MediaQuery.of(context).viewPadding.top),
                //       margin: EdgeInsets.only(
                //           left: 20.w, right: 16.w, bottom: 20.h),
                //       child: ProAndNotiWidget(
                //         scoreHead: Text(
                //           "cp_title".tr,
                //           style: TTextTheme.darkTextTheme.displayMedium,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }
}
