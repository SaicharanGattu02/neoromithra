import 'dart:convert';

class AppointmentsModel {
  bool? status;
  Data? data;

  AppointmentsModel({this.status, this.data});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<Appointments>? appointments;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.appointments,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      appointments = <Appointments>[];
      json['data'].forEach((v) {
        appointments!.add(new Appointments.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.appointments != null) {
      data['data'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Appointments {
  int? id;
  String? name;
  int? phone;
  String? appointmentFor;
  int? patientId;
  int? userId;
  int? age;
  String? gender;
  String? appointmentMode;
  String? appointmentRequestDate;
  String? serviceName;
  int? serviceId;
  int? days;
  List<String>? calenderDays; // Changed type
  int? amount;
  int? address;
  String? status;
  int? staffId;
  int? assignedId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Appointments({
    this.id,
    this.name,
    this.phone,
    this.appointmentFor,
    this.patientId,
    this.userId,
    this.age,
    this.gender,
    this.appointmentMode,
    this.appointmentRequestDate,
    this.serviceName,
    this.serviceId,
    this.days,
    this.calenderDays,
    this.amount,
    this.address,
    this.status,
    this.staffId,
    this.assignedId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    appointmentFor = json['appointment_for'];
    patientId = json['patient_id'];
    userId = json['user_id'];
    age = json['age'];
    gender = json['gender'];
    appointmentMode = json['appointment_mode'];
    appointmentRequestDate = json['appointment_request_date'];
    serviceName = json['service_name'];
    serviceId = json['service_id'];
    days = json['days'];

    // Fix calender_days deserialization for string or list
    if (json['calender_days'] is String) {
      try {
        calenderDays = List<String>.from(jsonDecode(json['calender_days']));
      } catch (e) {
        calenderDays = [];
      }
    } else if (json['calender_days'] is List) {
      calenderDays = List<String>.from(json['calender_days']);
    }

    amount = json['amount'];
    address = json['address'];
    status = json['status'];
    staffId = json['staff_id'];
    assignedId = json['assigned_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['appointment_for'] = appointmentFor;
    data['patient_id'] = patientId;
    data['user_id'] = userId;
    data['age'] = age;
    data['gender'] = gender;
    data['appointment_mode'] = appointmentMode;
    data['appointment_request_date'] = appointmentRequestDate;
    data['service_name'] = serviceName;
    data['service_id'] = serviceId;
    data['days'] = days;
    data['calender_days'] = calenderDays;
    data['amount'] = amount;
    data['address'] = address;
    data['status'] = status;
    data['staff_id'] = staffId;
    data['assigned_id'] = assignedId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
