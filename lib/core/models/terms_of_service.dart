class TermsOfServiceModel {
  int? id;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;
  String? type;

  TermsOfServiceModel({this.id, this.title, this.body, this.createdAt, this.updatedAt, this.type});

  TermsOfServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    return data;
  }
}
