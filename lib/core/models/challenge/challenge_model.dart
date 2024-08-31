// To parse this JSON data, do
//
//     final challenge = challengeFromJson(jsonString);

import 'dart:convert';

class ChallengeModel {
  final int? id;
  final String? title;
  final String? description;
  final String? thumb;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? prompText;
  final num? score;
  final String? logoImg;
  int? userCount;
  int? limit;
  bool? joined;
  String? taskText;
  String? userScore;
  int? isRequirePin;
  String? pin;
  String? webLink;
  int? contactNumber;
  String? goalText;
  String? prizeText;
  String? address;
  ChallengeModel({
    this.id,
    this.title,
    this.description,
    this.thumb,
    this.startDate,
    this.endDate,
    this.prompText,
    this.score,
    this.logoImg,
    this.userCount,
    this.limit,
    this.joined,
    this.taskText,
    this.userScore,
    this.isRequirePin,
    this.pin,
    this.webLink,
    this.contactNumber,
    this.goalText,
    this.prizeText,
    this.address,
  });

  factory ChallengeModel.fromRawJson(String str) =>
      ChallengeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => ChallengeModel(
        id: json["id"],
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
        userCount: json['user_count'],
        limit: json['limit'],
        joined: json['joined'],
        taskText: json['task_text'],
        userScore: json['user_score'],
        isRequirePin: json['is_require_pin'],
        pin: json['pin'],
        webLink: json['web_link'],
        contactNumber: json['contact_number'],
        goalText: json['goal_text'],
        prizeText: json['prize_text'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "thumb": thumb,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "promp_text": prompText,
        "score": score,
        "logo_img": logoImg,
        "user_count": userCount,
        "limit": limit,
        "joined": joined,
        "is_require_pin": isRequirePin,
        "pin": pin,
        "web_link": webLink,
        "contact_number": contactNumber,
        "goal_text": goalText,
        "prize_text": prizeText,
        "address": address,
      };
}
