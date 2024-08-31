class BadgesModel {
  int? id;
  String? name;
  int? kilo;
  String? image;

  BadgesModel({
    this.id,
    this.name,
    this.kilo,
    this.image,
  });

  BadgesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    kilo = json['kilometer'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['kilometer'] = this.kilo;
    data['image'] = this.image;
    return data;
  }
}
