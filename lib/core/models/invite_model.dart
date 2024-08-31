class InviteListModel {
  int? id;
  int? inviterUserId;
  String? referCode;
  int? status;
  String? createdAt;
  String? phone;

  InviteListModel(
      {this.id,
        this.inviterUserId,
        this.referCode,
        this.status,
        this.createdAt,
        this.phone,
      });

  InviteListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inviterUserId = json['inviter_user_id'];
    referCode = json['refer_code'];
    status = json['status'];
    createdAt = json['created_at'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inviter_user_id'] = this.inviterUserId;
    data['refer_code'] = this.referCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['phone'] = this.phone;
    return data;
  }
}