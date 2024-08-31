class User {
  int? id;
  int? role;
  String? login;
  String? password;
  String? avatar;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  int? verifyCode;
  int? isVerified;
  int? referCode;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? gender;
  String? birthday;
  int? invitedUserReferCode;
  int? showLog;
  String? height;
  String? weight;
  String? aimagHot;
  String? sumDuureg;
  String? bdayGiftDate;
  int? badge;

  User({
    this.id,
    this.role,
    this.login,
    this.password,
    this.avatar,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.verifyCode,
    this.isVerified,
    this.referCode,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.gender,
    this.birthday,
    this.invitedUserReferCode,
    this.showLog,
    this.height,
    this.weight,
    this.aimagHot,
    this.sumDuureg,
    this.bdayGiftDate,
    this.badge,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    login = json['login'];
    password = json['password'];
    avatar = json['avatar'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    verifyCode = json['verify_code'];
    isVerified = json['is_verified'];
    referCode = json['refer_code'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    gender = json['gender'] == null ? 'm' : json['gender'];
    birthday = json['birthday'];
    invitedUserReferCode = json['invited_user_refer_code'];
    showLog = json['show_log'];
    height = json['height'] == null ? '170' : json['height'];
    weight = json['weight'] == null ? '70' : json['weight'];
    aimagHot = json['aimag_hot'] == null ? "" : json['aimag_hot'];
    sumDuureg = json['sum_duureg'] == null ? "" : json['sum_duureg'];
    bdayGiftDate = json['bday_gift_date'];
    badge = json['badge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['login'] = this.login;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['verify_code'] = this.verifyCode;
    data['is_verified'] = this.isVerified;
    data['refer_code'] = this.referCode;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['invited_user_refer_code'] = this.invitedUserReferCode;
    data['show_log'] = this.showLog;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['aimag_hot'] = this.weight;
    data['sum_duureg'] = this.weight;
    data['bday_gift_date'] = this.bdayGiftDate;
    data['badge'] = this.badge;
    return data;
  }
}
