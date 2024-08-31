import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:move_to_earn/core/constants/image_strings.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/ui/views/home/score_log_page.dart';
import '../../../core/constants/controllers.dart';
import '../../../core/constants/values.dart';

class ScoreForHeader extends StatelessWidget {
  const ScoreForHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // var balance = totalPoint.obs.value;
    // int dotIndex = balance.indexOf('.');
    // // if (balance != "null") {
    // //   balance.substring(0, dotIndex);
    // // }
    // var coin = balance.substring(0, dotIndex);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        hideForIos
            ? const SizedBox()
            : Material(
                color: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    // color: Util.fromHex("#100025"),
                    // color: mainWhite.withOpacity(0.2),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ScoreLogPage());
                    },
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 10.w, left: 10.w, top: 12.h, bottom: 6.h),
                      child: Row(
                        children: [
                          Image.asset(
                            newcoin,
                            height: careIconSize.w,
                            width: careIconSize.w,
                          ),
                          // SvgPicture.asset(
                          //   careIcon,
                          //   height: careIconSize.w,
                          //   width: careIconSize.w,
                          //   colorFilter: ColorFilter.mode(
                          //     Colors.white,
                          //     BlendMode.srcIn,
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: GetBuilder(
                                init: appController,
                                builder: (_) {
                                  if (appController.pointLoading) {
                                    return Center(
                                        child: SpinKitRipple(
                                      color: mainWhite,
                                      size: 30.0.r,
                                    ));
                                  }
                                  return Obx(
                                    () => RichText(
                                      text: TextSpan(
                                        text: NumberFormat()
                                            .format(appController.point.value),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          // Container(
                          //   height: 24.w,
                          //   width: 24.w,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: Colors.white.withOpacity(0.2)),
                          //   child: Center(
                          //     child: Icon(
                          //       Icons.add,
                          //       color: Colors.white,
                          //       size: 16.sp,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  // Widget getCoin() {
  //   String balance = totalPoint.toString();
  //   int dotIndex = balance.indexOf('.');
  //   String coin = balance.substring(0, dotIndex);
  //   return Obx(
  //     () => RichText(
  //       text: TextSpan(
  //         text: 'coin',
  //         style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 14.sp,
  //             fontWeight: FontWeight.normal),
  //         children: <TextSpan>[
  //           TextSpan(
  //             text: 'C',
  //             style: TextStyle(color: Colors.white, fontSize: 14.sp),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
