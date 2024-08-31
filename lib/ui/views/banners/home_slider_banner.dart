import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/controllers.dart';
import '../../../core/constants/values.dart';

class HomeSlideBanner extends StatelessWidget {
  const HomeSlideBanner({super.key});

  Future<void> _launchUrl(_url) async {
    Get.put(AppController());

    try {
      if (!await launchUrl(_url)) {
        Get.rawSnackbar(
          messageText: Text(
            "Url can't launch",
            textAlign: TextAlign.center,
            style: TextStyle(color: mainWhite),
          ),
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          // margin: EdgeInsets.only(left: 36.w, right: 36.w),
          snackPosition: SnackPosition.BOTTOM,
          // borderRadius: 12.r,
        );
      }
    } on PlatformException catch (e) {
      Get.rawSnackbar(
        messageText: Text(
          e.message ?? "Url can't launch",
          textAlign: TextAlign.center,
          style: TextStyle(color: mainWhite),
        ),
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        // margin: EdgeInsets.only(left: 36.w, right: 36.w),
        snackPosition: SnackPosition.BOTTOM,
        // borderRadius: 12.r,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.bannerList.length > 0
        ? CarouselSlider.builder(
            carouselController: CarouselController(),
            itemCount: appController.bannerList.length,
            itemBuilder: (context, index, realIndex) {
              // return Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(20.r),
              //     ),
              //     image: DecorationImage(
              //       // image: imageProvider,
              //       image: CachedNetworkImageProvider(
              //         baseUrl + appController.bannerList[index].image!,

              //       ),
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              //   child: InkWell(
              //     onTap: () {
              //       _launchUrl(
              //           Uri.parse(appController.bannerList[index].link!));
              //     },
              //   ),
              // );
              return CachedNetworkImage(
                imageUrl: baseUrl + appController.bannerList[index].image!,
                memCacheWidth: (MediaQuery.of(context).size.width *
                        MediaQuery.of(context).devicePixelRatio)
                    .round(),
                filterQuality: FilterQuality.low,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.4,
                      color: mainWhite,
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        _launchUrl(
                            Uri.parse(appController.bannerList[index].link!));
                      },
                    ),
                  );
                },
              );
            },
            options: CarouselOptions(
              height: 260.h,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.23,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
          )
        : SizedBox());
    //   return Obx(() => appController.bannerList.length > 0
    //       ? CarouselSlider(
    //           items: appController.bannerList.map((e) {
    //             return InkWell(
    //               onTap: (() {
    //                 _launchUrl(Uri.parse(e.link!));
    //               }),
    //               child:
    //               Container(
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.all(
    //                     Radius.circular(20.r),
    //                   ),
    //                   image: DecorationImage(
    //                       image: NetworkImage(
    //                         baseUrl + e.image!,
    //                       ),
    //                       fit: BoxFit.fill),
    //                 ),
    //               ),
    //             );
    //           }).toList(),
    //           options: CarouselOptions(
    //             height: 260.h,
    //             viewportFraction: 0.8,
    //             initialPage: 0,
    //             enableInfiniteScroll: true,
    //             reverse: false,
    //             autoPlay: true,
    //             autoPlayInterval: Duration(seconds: 3),
    //             autoPlayAnimationDuration: Duration(milliseconds: 800),
    //             autoPlayCurve: Curves.fastOutSlowIn,
    //             enlargeCenterPage: true,
    //             enlargeFactor: 0.3,
    //             // onPageChanged: callbackFunction,
    //             scrollDirection: Axis.horizontal,
    //           ),
    //         )
    //       : SizedBox());
    // }
  }
}
