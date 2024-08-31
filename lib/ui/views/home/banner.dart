import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/controllers.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({super.key});

  @override
  State<BannerHome> createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
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
    return Obx(() => Stack(
          children: [
            if (appController.smallBannerList.isNotEmpty)
              ...appController.smallBannerList.map((e) {
                return Container(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl(Uri.parse(e.link!));
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 135.h,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(12.w),
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(widgetRadius.r),
                              ),
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                '$baseUrl' '${e.image}',
                                maxWidth: (MediaQuery.of(context).size.width *
                                        MediaQuery.of(context).devicePixelRatio)
                                    .round(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ));
  }
}
