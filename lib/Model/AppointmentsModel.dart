import 'dart:convert';

class AppointmentsModel {
  bool? status;
  Data? data;

  AppointmentsModel({this.status, this.data});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
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

  Data({
    this.currentPage,
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
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      appointments = <Appointments>[];
      json['data'].forEach((v) {
        appointments!.add(Appointments.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
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
    final Map<String, dynamic> data = {};
    data['current_page'] = currentPage;
    if (appointments != null) {
      data['data'] = appointments!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Appointments {
  dynamic id;
  String? name;
  dynamic phone;
  String? appointmentFor;
  dynamic patientId;
  dynamic userId;
  dynamic age;
  String? gender;
  String? appointmentMode;
  String? appointmentRequestDate;
  String? serviceName;
  dynamic serviceId;
  dynamic days;
  List<String>? calenderDays;
  dynamic amount;
  dynamic address; // Changed to dynamic to handle both int and String
  String? status;
  dynamic staffId;
  dynamic assignedId;
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
    name = json['name']?.toString();
    phone = json['phone']; // Keep dynamic to handle int or String
    appointmentFor = json['appointment_for']?.toString();
    patientId = json['patient_id'];
    userId = json['user_id'];
    age = json['age'];
    gender = json['gender']?.toString();
    appointmentMode = json['appointment_mode']?.toString();
    appointmentRequestDate = json['appointment_request_date']?.toString();
    serviceName = json['service_name']?.toString();
    serviceId = json['service_id'];
    days = json['days'];
    // Handle calender_days deserialization
    if (json['calender_days'] is String) {
      try {
        calenderDays = List<String>.from(jsonDecode(json['calender_days']));
      } catch (e) {
        calenderDays = [];
      }
    } else if (json['calender_days'] is List) {
      calenderDays = List<String>.from(json['calender_days'].map((e) => e.toString()));
    } else {
      calenderDays = [];
    }
    amount = json['amount'];
    address = json['address']; // Keep dynamic to handle int or String
    status = json['status']?.toString();
    staffId = json['staff_id'];
    assignedId = json['assigned_id'];
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
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
    data['calender_days'] = calenderDays != null ? jsonEncode(calenderDays) : null;
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
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}