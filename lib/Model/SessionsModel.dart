class SessionsModel {
  bool? status;
  List<Sessions>? sessions;

  SessionsModel({this.status, this.sessions});

  SessionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      sessions = <Sessions>[];
      json['data'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (sessions != null) {
      data['data'] = sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  int? slotId;
  String? date;
  String? startTime;
  String? endTime;
  String? rawStatus;
  String? computedStatus;
  String? url;
  String? feedback; // Added to match JSON
  Staff? staff;
  User? user;
  String? meetUrl;

  Sessions({
    this.slotId,
    this.date,
    this.startTime,
    this.endTime,
    this.rawStatus,
    this.computedStatus,
    this.url,
    this.feedback,
    this.staff,
    this.user,
    this.meetUrl,
  });

  Sessions.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    rawStatus = json['raw_status'];
    computedStatus = json['computed_status'];
    url = json['url'];
    feedback = json['feedback']; // Added to handle JSON field
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    meetUrl = json['meet_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['slot_id'] = slotId;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['raw_status'] = rawStatus;
    data['computed_status'] = computedStatus;
    data['url'] = url;
    data['feedback'] = feedback; // Added to serialize field
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['meet_url'] = meetUrl;
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
  String? age; // Changed from int? to String? to match JSON
  String? gender;

  User({this.id, this.name, this.age, this.gender});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age']; // Now expects a String
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