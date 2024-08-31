import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/challenge/challenge_model.dart';
import 'package:move_to_earn/ui/component/countdown_date.dart';
import 'package:move_to_earn/ui/views/challenge/challenge_detail.dart';
import 'package:move_to_earn/utils/case_extension.dart';
import 'package:move_to_earn/utils/number.dart';
import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';
import '../../../core/controllers/challenge_controller.dart';

class ChallengeHomeBox extends StatelessWidget {
  final ChallengeModel e;

  const ChallengeHomeBox({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    ChallengeController controller = Get.find();

    return InkWell(
      onTap: () {
        Get.to(() => ChallengeDetail(data: e));
      },
      child: Stack(
        children: [
          Container(
            width: myChallengeW.w,
            height: myChallengeH.h,
            padding: EdgeInsets.all(13.w),
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widgetRadius.w),
              color: mainWhite.withOpacity(0.2),
            ),
            child: Row(
              children: [
                e.logoImg != null
                    ? CachedNetworkImage(
                        imageUrl: baseUrl + e.logoImg!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 64.w,
                          height: 64.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widgetRadius.r),
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        errorWidget: (context, ss, ff) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.circular(widgetRadius.r),
                            ),
                            width: 64.w,
                            height: 64.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              "cp_unable_load_image".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: mainWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                SizedBox(
                  width: 16.w,
                ),
                Flexible(
                  child: Column(
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
                        padding: EdgeInsets.only(left: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  myChallengeStepIcon,
                                  height: 12.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  ": " + formatNumber(e.userScore) + " алхсан",
                                  style: TTextTheme.darkTextTheme.headlineSmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  myChallengeInviteIcon,
                                  height: 12.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  ": " +
                                      controller.invites.length.toString() +
                                      " урьсан",
                                  style: TTextTheme.darkTextTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  bottomLeft: Radius.circular(widgetRadius.r),
                  topRight: Radius.circular(widgetRadius.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
              child: Text(
                (e.userCount).toString(),
                style: TextStyle(
                  color: mainWhite,
                  fontSize: 12.w,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0 + 16.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widgetRadius.r),
                          bottomRight: Radius.circular(widgetRadius.r),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                      child: CountDownDate(
                        date: e.endDate!,
                        fontSize: 12.w,
                        showSecond: false,
                      )
                      // ),
                      ),
                ],
              ))
        ],
      ),
    );
  }
}
