class SumDuuregModel {
  int? id;
  String? name;
  String? short;
  int? aimagId;

  SumDuuregModel({
    this.id,
    this.name,
    this.short,
    this.aimagId,
  });

  SumDuuregModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    short = json['short'];
    aimagId = json['aimag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short'] = this.short;
    data['aimag_id'] = this.aimagId;

    return data;
  }
}
