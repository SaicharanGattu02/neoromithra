class SessionsModel {
  bool? status;
  List<Sessions>? sessions;

  SessionsModel({this.status, this.sessions});

  SessionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null && json['data']['data'] != null) {
      sessions = <Sessions>[];
      json['data']['data'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (sessions != null) {
      data['data'] = {'data': sessions!.map((v) => v.toJson()).toList()};
    }
    return data;
  }
}

class Sessions {
  int? slotId;
  String? appId;
  String? date;
  String? startTime;
  String? endTime;
  String? rawStatus;
  String? computedStatus;
  String? meetUrl;
  String? feedback;
  Staff? staff;
  User? user;

  Sessions({
    this.slotId,
    this.appId,
    this.date,
    this.startTime,
    this.endTime,
    this.rawStatus,
    this.computedStatus,
    this.meetUrl,
    this.feedback,
    this.staff,
    this.user,
  });

  Sessions.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'] is int
        ? json['slot_id']
        : int.tryParse(json['slot_id'].toString());
    appId = json['app_id']?.toString();
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    rawStatus = json['raw_status'];
    computedStatus = json['computed_status'];
    meetUrl = json['meet_url'];
    feedback = json['feedback']?.toString();
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['slot_id'] = slotId;
    data['app_id'] = appId;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['raw_status'] = rawStatus;
    data['computed_status'] = computedStatus;
    data['meet_url'] = meetUrl;
    data['feedback'] = feedback;
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Staff {
  int? id;
  String? name;
  String? email;

  Staff({this.id, this.name, this.email});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? age;
  String? gender;

  User({this.id, this.name, this.age, this.gender});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['gender'] = gender;
    return data;
  }
}