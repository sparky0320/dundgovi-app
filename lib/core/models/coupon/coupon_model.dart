// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

class CouponModel {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? price;
  final String? point;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic type;
  final int? category;
  final int? sale;
  final DateTime? date;
  final String? endDate;
  final String? merchantName;
  dynamic item;
  final String? logo;
  final int? limit;
  final int? status;
  final int? usageStatus;
  final int? count;
  final String? subTitle;
  final String? address;
  final int? contactNumber;
  final String? fbLink;
  final String? instaLink;
  final String? webLink;
  final int? isPinned;
  final double? lat;
  final double? long;
  final int? distance;
  final String? locationDetail;

  CouponModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
    this.point,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.category,
    this.sale,
    this.date,
    this.endDate,
    this.merchantName,
    this.item,
    this.logo,
    this.limit,
    this.status,
    this.usageStatus,
    this.count,
    this.subTitle,
    this.address,
    this.contactNumber,
    this.fbLink,
    this.instaLink,
    this.webLink,
    this.isPinned,
    this.lat,
    this.long,
    this.distance,
    this.locationDetail,
  });

  factory CouponModel.fromRawJson(String str) =>
      CouponModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        point: json["point"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        type: json["type"],
        category: json["category"],
        sale: json["sale"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        endDate: json["end_date"],
        merchantName: json['merchant_name'],
        item: json['item'],
        logo: json['logo'],
        limit: json['limit'],
        status: json['status'],
        usageStatus: json['usage_status'],
        count: json['count'],
        subTitle: json['sub_title'],
        address: json['address'],
        contactNumber: json['contact_number'],
        fbLink: json['fb_link'],
        instaLink: json['insta_link'],
        webLink: json['web_link'],
        isPinned: json['is_pinned'],
        lat: json["latitude"] != null ? double.parse(json["latitude"]) : 0,
        long: json["longitude"] != null ? double.parse(json["longitude"]) : 0,
        distance: json["distance"] ?? 0,
        locationDetail: json["location_detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "price": price,
        "point": point,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type,
        "category": category,
        "sale": sale,
        "date": date?.toIso8601String(),
        "end_date": endDate,
        'merchant_name': merchantName,
        'item': item,
        'status': status,
        'usage_status': usageStatus,
        'logo': logo,
        'sub_title': subTitle,
        'address': address,
        'contact_number': contactNumber,
        'fb_link': fbLink,
        'insta_link': instaLink,
        'web_link': webLink,
        'is_pinned': isPinned,
        'location_detail': locationDetail,
      };
}
