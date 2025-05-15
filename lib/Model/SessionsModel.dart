class SessionsModel {
  bool? status;
  List<Sessions>? sessions;

  SessionsModel({this.status, this.sessions});

  SessionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      sessions = <Sessions>[];
      json['data'].forEach((v) {
        sessions!.add(new Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sessions != null) {
      data['data'] = this.sessions!.map((v) => v.toJson()).toList();
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
  Staff? staff;
  User? user;
  String? meetUrl;

  Sessions(
      {this.slotId,
        this.date,
        this.startTime,
        this.endTime,
        this.rawStatus,
        this.computedStatus,
        this.url,
        this.staff,
        this.user,
        this.meetUrl});

  Sessions.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    rawStatus = json['raw_status'];
    computedStatus = json['computed_status'];
    url = json['url'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    meetUrl = json['meet_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot_id'] = this.slotId;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['raw_status'] = this.rawStatus;
    data['computed_status'] = this.computedStatus;
    data['url'] = this.url;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['meet_url'] = this.meetUrl;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class User {
  int? id;
  String? name;
  int? age;
  String? gender;

  User({this.id, this.name, this.age, this.gender});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    return data;
  }
}
