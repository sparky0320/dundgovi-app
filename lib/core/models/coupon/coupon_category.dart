// To parse this JSON data, do
//
//     final couponCategory = couponCategoryFromJson(jsonString);

import 'dart:convert';

import 'package:move_to_earn/core/models/coupon/coupon_model.dart';

class CouponCategory {
  final int? id;
  final String? title;
  final int? ordr;
  final int? status;
  final List<CouponModel>? coupons;

  CouponCategory({
    this.id,
    this.title,
    this.ordr,
    this.status,
    this.coupons,
  });

  factory CouponCategory.fromRawJson(String str) =>
      CouponCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponCategory.fromJson(Map<String, dynamic> json) => CouponCategory(
        id: json["id"],
        title: json["title"],
        ordr: json["ordr"],
        status: json["status"],
        coupons: json["coupons"] == null
            ? []
            : List<CouponModel>.from(
                json["coupons"]!.map((x) => CouponModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "ordr": ordr,
        "status": status,
        "coupons": coupons == null
            ? []
            : List<dynamic>.from(coupons!.map((x) => x.toJson())),
      };
}
