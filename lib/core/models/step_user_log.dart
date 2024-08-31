class UserStepLog {
  int? id;
  int? userId;
  int? stepCount;
  String? date;

  UserStepLog({
    this.id,
    this.userId,
    this.stepCount,
    this.date,
  });

  UserStepLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    stepCount = json['step_count'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['step_count'] = this.stepCount;
    data['date'] = this.date;
    return data;
  }
}
