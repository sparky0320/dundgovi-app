import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/utils/date.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/coupon/coupon_model.dart';
import 'package:move_to_earn/utils/number.dart';

class CouponBanner extends StatelessWidget {
  const CouponBanner(
      {required this.getTo,
      required this.image,
      required this.height,
      required this.width,
      required this.coupon});

  final getTo;
  final String? image;
  final double height;
  final double width;
  final CouponModel coupon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getTo,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: mainWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.w)),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    // margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    child: image != null
                        ? CachedNetworkImage(
                            imageUrl: baseUrl + image!,
                            height: height,
                            width: width,
                            fit: BoxFit.cover,
                            // assets/images/avatar.png
                            errorWidget: (context, ss, ff) {
                              return Container(
                                height: height,
                                width: width,
                                color: Colors.black26,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(14),
                                child: Text(
                                  "cp_unable_load_image".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.white54),
                                ),
                              );
                            },
                          )
                        : Container(
                            height: height,
                            width: width,
                            color: Colors.black26,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(14.w),
                            child: Text(
                              "cp_image_not_found".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white54),
                            ),
                          ),
                  )),
              Expanded(
                  flex: 5,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coupon.title ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.sp, color: mainWhite),
                              ),
                              coupon.sale == null
                                  ? const SizedBox()
                                  : Text(
                                      coupon.sale!.toString() +
                                          "% ${'cp_hongololt'.tr}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: mainWhite.withOpacity(0.8)),
                                    ),
                              coupon.price == null
                                  ? const SizedBox()
                                  : Container(
                                      padding: EdgeInsets.all(3.r),
                                      margin: EdgeInsets.only(bottom: 4.h),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4.r),
                                          ),
                                          color: ColorConstants.neutralColor2),
                                      child: FittedBox(
                                        child: Text(
                                          "${'cp_hudaldah_vne'.tr} ${formatNumber(coupon.price)}",
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                              coupon.date == null
                                  ? const SizedBox()
                                  : Text(
                                      getDate(coupon.date!),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.sp,
                                          color: mainWhite),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
