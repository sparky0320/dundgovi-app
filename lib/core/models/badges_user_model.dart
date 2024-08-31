class BadgesUserModel {
  int? id;
  int? badgeid;
  int? userid;
  String? createdat;

  BadgesUserModel({
    this.id,
    this.badgeid,
    this.userid,
    this.createdat,
  });

  BadgesUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    badgeid = json['badge_id'];
    userid = json['user_id'];
    createdat = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['badge_id'] = this.badgeid;
    data['user_id'] = this.userid;
    data['created_at'] = this.createdat;
    return data;
  }
}
