class StepModel {
  int? id;
  int? count;
  String? date;
  // String? createdAt;
  int? userId;
  int? dailyGoal;
  double? calorie;
  double? travelLength;
  int? weight;
  int? stepLength;
  int? height;
  int? weekDay;
  String? weekdayName;

  StepModel({
    this.id,
    this.count,
    this.date,
    // this.createdAt,
    this.userId,
    this.dailyGoal,
    this.calorie,
    this.travelLength,
    this.weight,
    this.stepLength,
    this.height,
    this.weekDay,
    this.weekdayName,
  });

  StepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['step_count'] != null ? json['step_count'] : json['count'];
    date = json['date'];
    // createdAt = json['created_at'];
    userId = json['user_id'];
    dailyGoal = json['daily_goal'];
    calorie = double.parse(json['calorie'].toString());
    travelLength = double.parse(json['travel_length'].toString());
    weight = json['weigth'];
    stepLength = json['step_length'];
    height = json['heigth'];
    weekDay = json['weekday'];
    weekdayName = json['weekday_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['step_count'] = this.count;
    data['date'] = this.date;
    // data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    data['daily_goal'] = this.dailyGoal;
    data['calorie'] = this.calorie;
    data['travel_length'] = this.travelLength;
    data['weigth'] = this.weight;
    data['step_length'] = this.stepLength;
    data['heigth'] = this.height;
    data['weekday'] = this.weekDay;
    data['weekday_name'] = this.weekdayName;
    return data;
  }
}

class NewStepModel {
  int? id;
  int? count;
  String? date;
  int? userId;
  int? dailyGoal;
  double? calorie;
  double? travelLength;
  int? weight;
  double? stepLength;
  int? height;
  int? weekDay;

  NewStepModel({
    this.id,
    this.count,
    this.date,
    // this.createdAt,
    this.userId,
    this.dailyGoal,
    this.calorie,
    this.travelLength,
    this.weight,
    this.stepLength,
    this.height,
    this.weekDay,
  });

  NewStepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['step_count'];
    date = json['date'];
    // createdAt = json['created_at'];
    userId = json['user_id'];
    dailyGoal = json['daily_goal'];
    calorie = double.parse(json['calorie'].toString());
    travelLength = double.parse(json['travel_length'].toString());
    weight = json['weigth'];
    stepLength = json['step_length'];
    height = json['heigth'];
    weekDay = json['weekday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['step_count'] = this.count;
    data['date'] = this.date;
    // data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    data['daily_goal'] = this.dailyGoal;
    data['calorie'] = this.calorie;
    data['travel_length'] = this.travelLength;
    data['weigth'] = this.weight;
    data['step_length'] = this.stepLength;
    data['heigth'] = this.height;
    data['weekday'] = this.weekDay;
    return data;
  }
}

class NewWeekStepModel {
  int? id;
  int? count;
  String? date;
  int? userId;
  int? dailyGoal;
  double? calorie;
  double? travelLength;
  int? weight;
  int? stepLength;
  int? height;
  // int? weekDay;

  NewWeekStepModel({
    this.id,
    this.count,
    this.date,
    // this.createdAt,
    this.userId,
    this.dailyGoal,
    this.calorie,
    this.travelLength,
    this.weight,
    this.stepLength,
    this.height,
    // this.weekDay,
  });

  NewWeekStepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['step_count'];
    date = json['date'];
    // createdAt = json['created_at'];
    userId = json['user_id'];
    dailyGoal = json['daily_goal'];
    calorie = double.parse(json['calorie'].toString());
    travelLength = double.parse(json['travel_length'].toString());
    weight = json['weigth'];
    stepLength = json['step_length'];
    height = json['heigth'];
    // weekDay = json['weekday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['step_count'] = this.count;
    data['date'] = this.date;
    // data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    data['daily_goal'] = this.dailyGoal;
    data['calorie'] = this.calorie;
    data['travel_length'] = this.travelLength;
    data['weigth'] = this.weight;
    data['step_length'] = this.stepLength;
    data['heigth'] = this.height;
    // data['weekday'] = this.weekDay;
    return data;
  }
}
