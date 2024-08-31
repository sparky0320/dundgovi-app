import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lambda/utils/hexColor.dart';
import 'package:move_to_earn/core/constants/util.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:move_to_earn/core/models/coupon/coupon_model.dart';
import 'package:move_to_earn/ui/component/countdown_date.dart';
import 'package:move_to_earn/ui/views/coupon/coupon_detail.dart';

class CouponCard extends StatefulWidget {
  final CouponModel coupon;

  const CouponCard({super.key, required this.coupon});

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        margin: EdgeInsets.only(bottom: 18),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Get.to(() => CouponDetail(data: widget.coupon));
            },
            child: Stack(
              children: [
                Container(
                  color: HexColor("241542"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.coupon.item != null &&
                              widget.coupon.item['end_date'] != null
                          ? Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "${widget.coupon.item['end_date']} хүртэл хүчинтэй",
                                    style: TextStyle(
                                        color: mainWhite, fontSize: 12),
                                  ),
                                ),
                                DateTime.parse(widget.coupon.item['end_date'])
                                        .isBefore(DateTime.now())
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Util.fromHex("#EECB73"),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Text("Хугацаа дууссан",
                                            style: TextStyle(fontSize: 12)),
                                      )
                                    : const SizedBox(),
                                widget.coupon.item['status'] == 1
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Util.fromHex("#EECB73"),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Text("mcp_ashiglasan".tr,
                                            style: TextStyle(fontSize: 12)),
                                      )
                                    : const SizedBox(),
                              ],
                            )
                          : const SizedBox(),
                      widget.coupon.logo != null
                          ? CachedNetworkImage(
                              imageUrl: baseUrl + widget.coupon.logo!,
                              // height: height,
                              // width: width,
                              fit: BoxFit.cover,
                              // assets/images/avatar.png
                              errorWidget: (context, ss, ff) {
                                return Container(
                                  // height: height,
                                  // width: width,
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
                              // height: height,
                              // width: width,
                              color: Colors.black26,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(14),
                              child: Text(
                                "cp_image_not_found".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.white54),
                              ),
                            ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(widget.coupon.title ?? "",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: mainWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      ),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.white)),
                          child: Text(
                            "Дэлгэрэнгүй",
                            style: TextStyle(color: mainWhite),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 46.h,
                      )
                    ],
                  ),
                ),
                widget.coupon.item != null &&
                        widget.coupon.item['end_date'] != null &&
                        DateTime.tryParse(widget.coupon.item['end_date']) !=
                            null
                    ? Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: mainWhite.withOpacity(.3),
                              borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: CountDownDate(
                              fontSize: 12,
                              date: DateTime.parse(
                                  widget.coupon.item['end_date'])),
                        ))
                    : const SizedBox(),
                Positioned(
                    bottom: 8,
                    right: 4,
                    child: Image.asset('assets/images/gocare.png'))
              ],
            ),
          ),
        ),
      );
    });
  }
}
