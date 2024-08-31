class AimagModel {
  int? id;
  String? name;
  String? short;

  AimagModel({
    this.id,
    this.name,
    this.short,
  });

  AimagModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    short = json['short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short'] = this.short;

    return data;
  }
}
