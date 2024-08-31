import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class MyHomePageCtrl extends GetxController {
  bool loading = false;
  bool loadingGoal = false;
  AppController appController = Get.find();
  // final bannerCtrl = CouponPageCtrl();
  NetworkUtil _netUtil = Get.find();

  bool myChallengeLoading = false;
  bool adsLoading = true;

  RxNum totalPount = RxNum(0);

  bool isButtonEnabled = true;

  // void onInit() {
  //   super.initState();
  //
  // }

  //   Future checkPinExist(BuildContext context) async {
  //   final response = await _netUtil.post(
  //       baseUrl + '/api/pin/exist', {"user_id": appController.user.value.id});
  //   if (response != null && response['status'] == false) {
  //     Get.bottomSheet(Container(
  //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(24.w), topRight: Radius.circular(24))),
  //       child: Wrap(
  //         children: [
  //           Container(
  //             padding: EdgeInsets.symmetric(vertical: 32.w),
  //             child: Center(
  //                 child: Image.asset('assets/images/m2e_start.png',
  //                     height: 84, width: 84)),
  //           ),
  //           const SizedBox(height: 16),
  //           Center(
  //             child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 16.w),
  //               child: Text(
  //                 'h1_set_pass'.tr,
  //                 style: TextStyle(
  //                   fontSize: 20.w,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 80.w),
  //           Center(
  //             child: LoginSignUpButton(
  //               model: ButtonModel(
  //                 color1: ColorConstants.gradientColor1,
  //                 color2: ColorConstants.gradientColor2,
  //                 color3: ColorConstants.gradientColor3,
  //                 color4: ColorConstants.gradientColor4,
  //                 color5: ColorConstants.gradientColor5,
  //                 borderColor: Colors.transparent,
  //                 text: "h1_confirm".tr,
  //                 icon: "",
  //                 textStyle: TTextTheme.lightTextTheme.bodySmall,
  //                 getTo: () async {
  //                   Get.back();
  //                   // getData();
  //                   // setPinCodeDialog(context);
  //                 },
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ));
  //   }
  // }

  Future<bool> rewardedAd(dynamic item) async {
    // item['loading'] = true;
    adsLoading = true;
    try {
      await RewardedAd.load(
          adUnitId: Platform.isAndroid
              ? "ca-app-pub-8500838700347205/5914249260"
              : "ca-app-pub-8500838700347205/5411686380",
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                  // onAdShowedFullScreenContent: (ad) {},
                  onAdImpression: (ad) {},
                  onAdFailedToShowFullScreenContent: (ad, err) {
                    ad.dispose();
                  },
                  onAdDismissedFullScreenContent: (ad) {
                    ad.dispose();
                  },
                  onAdClicked: (ad) {});
              item['loading'] = false;
              adsLoading = false;
              update();
              debugPrint('$ad loaded.');
              ad.show(onUserEarnedReward:
                  (AdWithoutView ad, RewardItem rewardItem) async {
                try {
                  final response = await _netUtil.post(
                    baseUrl + '/api/ad/seen',
                    {
                      "user_id": appController.user.value.id,
                      "ad_id": item['id']
                    },
                  );
                  print('ads seen -----$response');
                  await appController.getAds();
                  if (response != null && response['status'] == true) {
                    item['seen'] = true;
                    appController.getPoint();
                    if (response['data'] != null) {
                      Get.snackbar(
                          "h1_added_point".tr,
                          "h1_your".tr +
                              ' ' +
                              response['data'].toString() +
                              ' ' +
                              "h1_added_point".tr,
                          backgroundColor: Colors.white.withOpacity(.7),
                          duration: Duration(seconds: 15));
                    }
                  } else if (response['msg'] != null) {
                    print('ads seen');
                    Get.snackbar("h1_ads".tr, response['msg'],
                        backgroundColor: Colors.white.withOpacity(.7));
                  }

                  update();
                } catch (e) {
                  Get.snackbar("h1_ads".tr, e.toString(),
                      backgroundColor: Colors.white.withOpacity(.7));
                  Navigator.pop(getContext);
                  update();
                  FirebaseCrashlytics.instance.recordError(
                    Exception(e),
                    StackTrace.current, // you should pass stackTrace in here
                    reason: e,
                    fatal: false,
                  );
                }
              });
            },
            // Called when an ad request failed.
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('RewardedAd failed to load: ${error.message}');
              Get.rawSnackbar(
                message: "ads_reached".tr,
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                icon: Icon(Iconsax.warning_2, color: mainWhite, size: 28.sp),
                margin: EdgeInsets.only(left: 36.w, right: 36.w),
                snackPosition: SnackPosition.TOP,
                borderRadius: 12.r,
              );
              item['loading'] = false;
              adsLoading = false;
              update();
            },
          ));
      return true;
    } catch (e) {
      print(' ads catch -----$e');
      Get.rawSnackbar(
        message: "ads_reached".tr,
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        icon: Icon(Iconsax.warning_2, color: mainWhite, size: 28.sp),
        margin: EdgeInsets.only(left: 36.w, right: 36.w),
        snackPosition: SnackPosition.TOP,
        borderRadius: 12.r,
      );
      item['loading'] = false;
      adsLoading = false;
      update();
      return false;
    }
  }

  // Future getChallengeGift() async {
  //   appController.gifts = [];i6o,
  //   try {
  //     final response = await _netUtil.post(baseUrl + '/api/challenge/gift',
  //         {"user_id": appController.user.value.id});
  //     if (response != null && response['status'] == true) {
  //       for (var item in response['data']) {
  //         appController.gifts.add(ChallengeGift.fromJson(item));
  //       }
  //     }
  //     update();
  //   } catch (e) {
  //     FirebaseCrashlytics.instance.recordError(
  //       Exception(e),
  //       StackTrace.current, // you should pass stackTrace in here
  //       reason: e,
  //       fatal: false,
  //     );
  //   }
  // }
}
