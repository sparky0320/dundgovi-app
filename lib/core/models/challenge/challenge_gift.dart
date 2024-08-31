import 'dart:convert';

import 'package:move_to_earn/core/models/coupon/coupon_model.dart';

class ChallengeGift {
  final int? id;
  final dynamic merchantId;
  final String? title;
  final String? description;
  final String? thumb;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? prompText;
  final int? score;
  final String? logoImg;
  final int? limit;
  final String? taskText;
  final int? status;
  final int? end;
  final int? rank;
  final int? couponId;
  final CouponModel? coupon;
  final int? userCount;

  ChallengeGift({
    this.id,
    this.merchantId,
    this.title,
    this.description,
    this.thumb,
    this.startDate,
    this.endDate,
    this.prompText,
    this.score,
    this.logoImg,
    this.limit,
    this.taskText,
    this.status,
    this.end,
    this.rank,
    this.couponId,
    this.coupon,
    this.userCount,
  });

  factory ChallengeGift.fromRawJson(String str) =>
      ChallengeGift.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChallengeGift.fromJson(Map<String, dynamic> json) => ChallengeGift(
        id: json["id"],
        merchantId: json["merchant_id"],
        title: json["title"],
        description: json["description"],
        thumb: json["thumb"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        prompText: json["promp_text"],
        score: json["score"],
        logoImg: json["logo_img"],
        limit: json["limit"],
        taskText: json["task_text"],
        status: json["status"],
        end: json["end"],
        rank: json["rank"],
        couponId: json["coupon_id"],
        coupon: json["coupon"] == null
            ? null
            : CouponModel.fromJson(json["coupon"]),
        userCount: json["user_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "merchant_id": merchantId,
        "title": title,
        "description": description,
        "thumb": thumb,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "promp_text": prompText,
        "score": score,
        "logo_img": logoImg,
        "limit": limit,
        "task_text": taskText,
        "status": status,
        "end": end,
        "rank": rank,
        "coupon_id": couponId,
        "coupon": coupon?.toJson(),
        "user_count": userCount,
      };
}
