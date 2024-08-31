import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/challenge/challenge_gift.dart';
import 'package:move_to_earn/ui/views/coupon/coupon_detail.dart';
import 'package:move_to_earn/utils/case_extension.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class ChallengeGiftCard extends StatelessWidget {
  final ChallengeGift e;
  const ChallengeGiftCard({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    // ChallengeController controller = Get.find();
    return InkWell(
      onTap: () {
        // Get.to(() => ChallengeDetail(data: e));
        if (e.coupon != null) {
          Get.to(() => CouponDetail(data: e.coupon!));
        }
      },
      child: Stack(
        children: [
          Container(
            width: myChallengeW.w,
            height: 120,
            padding: EdgeInsets.all(13.w),
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widgetRadius.w),
                color: ColorConstants.accentColor6.withOpacity(0.4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // e.logoImg != null
                    //     ? CachedNetworkImage(
                    //         imageUrl: baseUrl + e.logoImg!,
                    //         fit: BoxFit.contain,
                    //         width: myChallengeLogoW.w,
                    //       )
                    //     : const SizedBox(),
                    // SizedBox(
                    //   width: 16.w,
                    // ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.title!.toTitleCase(),
                            style: TextStyle(
                              color: mainWhite,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.w,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Та чалленжид ${e.rank}-р байр эзэлсэн байна",
                                        style: TTextTheme
                                            .darkTextTheme.headlineSmall,
                                      ),
                                    ),
                                  ],
                                ),
                                e.coupon != null
                                    ? Text(
                                        "Таны шагнал: " +
                                            (e.coupon!.title ?? ""),
                                        style: TTextTheme
                                            .darkTextTheme.headlineSmall,
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.w),
                  topRight: Radius.circular(6.w),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
              child: Text(
                "#${e.rank} байр",
                style: TextStyle(
                  color: mainWhite,
                  fontSize: 12.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
