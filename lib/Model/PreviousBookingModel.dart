class PreviousBookingModel {
  bool? status;
  List<Patients>? patients;

  PreviousBookingModel({this.status, this.patients});

  PreviousBookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients!.add(new Patients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.patients != null) {
      data['patients'] = this.patients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patients {
  int? pid;
  String? pname;
  int? page;
  int? assignedUser;

  Patients({this.pid, this.pname, this.page, this.assignedUser});

  Patients.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    pname = json['pname'];
    page = json['page'];
    assignedUser = json['assigned_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['pname'] = this.pname;
    data['page'] = this.page;
    data['assigned_user'] = this.assignedUser;
    return data;
  }
}
