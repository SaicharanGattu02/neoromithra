class UpcomingAppointmentsModel {
  bool? status;
  List<UpcomingAppointments>? upcomingAppointments;

  UpcomingAppointmentsModel({this.status, this.upcomingAppointments});

  UpcomingAppointmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      upcomingAppointments = <UpcomingAppointments>[];
      json['data'].forEach((v) {
        upcomingAppointments!.add(new UpcomingAppointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.upcomingAppointments != null) {
      data['data'] = this.upcomingAppointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingAppointments {
  int? appointmentId;
  String? appointmentMode;
  String? date;
  String? startTime;
  String? endTime;
  String? status;
  Staff? staff;
  String? url;

  UpcomingAppointments(
      {this.appointmentId,
        this.appointmentMode,
        this.date,
        this.startTime,
        this.endTime,
        this.status,
        this.staff,
        this.url});

  UpcomingAppointments.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    appointmentMode = json['appointment_mode'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['appointment_mode'] = this.appointmentMode;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    data['url'] = this.url;
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
