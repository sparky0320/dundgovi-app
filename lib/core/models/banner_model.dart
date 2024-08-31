class BannerModel {
  int? idBanner;
  String? link;
  String? image;
  String? createdAt;
  String? updatedAt;
  // int? isDarkhan;

  BannerModel({
    this.idBanner,
    this.link,
    this.image,
    this.createdAt,
    this.updatedAt,
    // this.isDarkhan,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    idBanner = json['id'];
    link = json['link'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // isDarkhan = json['is_darkhan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.idBanner;
    data['link'] = this.link;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // data['is_darkhan'] = this.isDarkhan;
    return data;
  }
}
