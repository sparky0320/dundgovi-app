import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/src/ad_containers.dart';
import 'package:move_to_earn/core/controllers/loading_circle.dart';
import '../../../core/constants/controllers.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/values.dart';
import '../../../core/controllers/homepage/my_home_page_controller.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key, NativeAd? ad});

  final orientation = 200;

  @override
  Widget build(BuildContext context) {
    final MyHomePageCtrl controller = Get.put(MyHomePageCtrl());
    var width;

    return Obx(() {
      if (appController.ads.length.obs == 1) {
        width = Get.width * 0.78;
      } else if (appController.ads.length.obs == 2) {
        width = Get.width * 0.38;
      } else if (appController.ads.length.obs == 3) {
        width = Get.width * .33;
      }
      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widgetRadius.w),
          color: mainWhite.withOpacity(0.2),
        ),
        height: 243.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'gop_surtchilgaa_vzeh'.tr,
            //   style: TextStyle(
            //       color: mainWhite,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 18.sp),
            // ),
            Text(
              "gop_surtchilgaa_vzeed_onoo_tsugluul".tr,
              style: TextStyle(
                color: mainWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 13.h),
            // data(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: appController.ads.map((e) {
                      return Container(
                        width: width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        margin: EdgeInsets.only(right: 16.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widgetRadius.r),
                            color: mainWhite.withOpacity(0.3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/gift_ads.png",
                              width: 53.w,
                            ),
                            Container(
                              width: 70.w,
                              child: Text(
                                "gop_care_beleg_neeh".tr,
                                style: TextStyle(
                                  color: mainWhite,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            e['seen'] != null && e['seen'] == true
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade700,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24.r),
                                      ),
                                    ),
                                    child: Text(
                                      "gop_vzsen".tr,
                                      style: TextStyle(color: mainWhite),
                                    ),
                                  )
                                : e['loading'] != null && e['loading'] == true
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        strokeWidth: 1.3,
                                        color: Colors.red,
                                      ))
                                    : InkWell(
                                        onTap: () async {
                                          showDialog<dynamic>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Container(
                                                  width: 220,
                                                  // height: 243,
                                                  color: Colors.transparent,
                                                  child: LoadingCircle(),
                                                ),
                                              );
                                            },
                                          );
                                          controller.isButtonEnabled = true;

                                          if (controller.isButtonEnabled) {
                                            print('updated----------');
                                            await controller.rewardedAd(e);
                                          }
                                          print('clicked----------');
                                          if (controller.isButtonEnabled) {
                                            controller.isButtonEnabled = false;
                                            controller.update();
                                          }

                                          Future.delayed(Duration(seconds: 8),
                                              () {
                                            controller.isButtonEnabled = false;
                                            controller.update();
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 2.h),
                                          decoration: BoxDecoration(
                                            color: mainWhite.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(24.r),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "gop_vzeh".tr,
                                                style: TextStyle(
                                                  color: mainBlack,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Icon(Icons.play_circle_outline),
                                            ],
                                          ),
                                        ),
                                      ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Widget data() {
  //   return Expanded(
  //       child: ListView.builder(
  //     itemCount: 2,
  //     shrinkWrap: true,
  //     scrollDirection: Axis.horizontal,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemBuilder: (_, index) {
  //       return hasData(index);
  //     },
  //   ));
  // }

  // Widget hasData(index) {
  //   var width;
  //   if (appController.ads.length == 1) {
  //     width = Get.width * 0.78;
  //   } else if (appController.ads.length == 2) {
  //     width = Get.width * 0.36;
  //   } else if (appController.ads.length == 3) {
  //     width = Get.width * .33;
  //   }
  //   var seen = appController.ads[index]['seen'];
  //   // List? e = ads[index] as List?;
  //   return Padding(
  //       padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Container(
  //             width: width,
  //             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(widgetRadius.r),
  //                 color: mainWhite.withOpacity(0.3)),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Image.asset(
  //                   "assets/images/gift_ads.png",
  //                   width: 53.w,
  //                 ),
  //                 Container(
  //                   width: 70.w,
  //                   child: Text(
  //                     "gop_care_beleg_neeh".tr,
  //                     style: TextStyle(
  //                       color: mainWhite,
  //                       fontSize: 11.sp,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                     overflow: TextOverflow.ellipsis,
  //                     maxLines: 2,
  //                   ),
  //                 ),
  //                 seen != null && seen == true
  //                     ? Container(
  //                         padding: EdgeInsets.symmetric(
  //                           horizontal: 20.w,
  //                           vertical: 9.h,
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.shade700,
  //                           borderRadius: BorderRadius.all(
  //                             Radius.circular(24.r),
  //                           ),
  //                         ),
  //                         child: Text(
  //                           "gop_vzsen".tr,
  //                           style: TextStyle(color: mainWhite),
  //                         ),
  //                       )
  //                     : index['loading'] != null && index['loading'] == true
  //                         ? Center(
  //                             child: CircularProgressIndicator(
  //                             strokeWidth: 1.3,
  //                             color: Colors.red,
  //                           ))
  //                         : InkWell(
  //                             onTap: () async {
  //                               var controller;
  //                               if (controller.isButtonEnabled) {
  //                                 print('updated----------');
  //                                 await controller.rewardedAd(e);
  //                               }
  //                               print('clicked----------');
  //                               if (controller.isButtonEnabled) {
  //                                 controller.isButtonEnabled = false;
  //                                 controller.update();
  //                               }
  //                               Future.delayed(Duration(seconds: 5), () {
  //                                 controller.isButtonEnabled = true;
  //                                 controller.update();
  //                               });
  //                             },
  //                             child: Container(
  //                               padding: EdgeInsets.symmetric(
  //                                   horizontal: 12.w, vertical: 7.h),
  //                               decoration: BoxDecoration(
  //                                 color: mainWhite.withOpacity(0.3),
  //                                 borderRadius: BorderRadius.circular(24.r),
  //                               ),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   Text(
  //                                     "gop_vzeh".tr,
  //                                     style: TextStyle(
  //                                       color: mainBlack,
  //                                       fontWeight: FontWeight.w700,
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 4.w,
  //                                   ),
  //                                   Icon(Icons.play_circle_outline),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                 SizedBox(height: 2.h),
  //               ],
  //             ),
  //           )
  //         ],
  //       ));
  // }
}
