// To parse this JSON data, do
//
//     final challenge = challengeFromJson(jsonString);

import 'dart:convert';

class ChallengeListModel {
  final int? id;
  final int? merchantId;
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
  final int? langId;
  final int? locationId;
  final int? requestStatus;
  final int? userCount;
  final bool? joined;
  ChallengeListModel(
      {this.id,
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
      this.langId,
      this.locationId,
      this.requestStatus,
      this.userCount,
      this.joined});

  factory ChallengeListModel.fromRawJson(String str) =>
      ChallengeListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChallengeListModel.fromJson(Map<String, dynamic> json) =>
      ChallengeListModel(
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
        logoImg: json['logo_img'],
        limit: json['limit'],
        taskText: json['task_text'],
        status: json['status'],
        end: json['end'],
        langId: json['lang_id'],
        locationId: json['location_id'],
        requestStatus: json['request_status'],
        userCount: json['user_count'],
        joined: json['joined'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "merchant_id": merchantId,
        "title": title,
        "description": description,
        "thumb": thumb,
        "start_date": startDate,
        "end_date": endDate,
        "promp_text": prompText,
        "score": score,
        "logo_img": logoImg,
        "limit": limit,
        "task_text": taskText,
        "status": status,
        "end": end,
        "lang_id": langId,
        "location_id": locationId,
        "request_status": requestStatus,
        "user_count": userCount,
        "joined": joined
      };
}
