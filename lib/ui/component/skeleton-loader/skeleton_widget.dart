import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackColor(),
        HeaderForPage(text: "Купон"),
        Container(
          padding: EdgeInsets.only(top: 95.w),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => Container(
              child: SkeletonItem(
                child: Column(
                  children: [
                    // HeaderForBanner(
                    //   text: "Миний купон",
                    //   getTo: () => {},
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                          lines: 1,
                          lineStyle: SkeletonLineStyle(
                            height: 28.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              borderRadius: BorderRadius.circular(20),
                              height: couponHeight.w,
                              width: couponWidth.w,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              borderRadius: BorderRadius.circular(20),
                              height: couponHeight.w,
                              width: couponWidth.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
