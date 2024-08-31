class LanguageModel {
  int? id;
  String? code;
  String? flag;
  String? language;
  int? isActive;

  LanguageModel({this.id, this.code, this.flag, this.language, this.isActive});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    flag = json['flag'];
    language = json['language'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['flag'] = this.flag;
    data['language'] = this.language;
    data['is_active'] = this.isActive;
    return data;
  }
}
