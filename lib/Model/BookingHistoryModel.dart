class BookingHistoryModel {
  List<BookingHistory>? bookingHistory;
  bool? status;

  BookingHistoryModel({this.bookingHistory, this.status});

  BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['booking_history'] != null) {
      bookingHistory = <BookingHistory>[];
      json['booking_history'].forEach((v) {
        bookingHistory!.add(new BookingHistory.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingHistory != null) {
      data['booking_history'] =
          this.bookingHistory!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class BookingHistory {
  int? id;
  String? fullName;
  int? phoneNumber;
  String? appointment;
  int? age;
  int? appointmentType;
  String? dateOfAppointment;
  String? location;
  String? pageSource;
  int? appointmentStatus;
  String? timeOfAppointment;
  int? therapistId;
  int? userId;
  String? filePath;
  int? ratingStatus;

  BookingHistory(
      {this.id,
        this.fullName,
        this.phoneNumber,
        this.appointment,
        this.age,
        this.appointmentType,
        this.dateOfAppointment,
        this.location,
        this.pageSource,
        this.appointmentStatus,
        this.timeOfAppointment,
        this.therapistId,
        this.userId,
        this.filePath,
        this.ratingStatus});

  BookingHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['Full_Name'];
    phoneNumber = json['phone_Number'];
    appointment = json['appointment'];
    age = json['age'];
    appointmentType = json['appointment_type'];
    dateOfAppointment = json['Date_of_appointment'];
    location = json['location'];
    pageSource = json['page_source'];
    appointmentStatus = json['appointment_status'];
    timeOfAppointment = json['time_of_appointment'];
    therapistId = json['therapist_id'];
    userId = json['user_id'];
    filePath = json['file_path'];
    ratingStatus = json['rating_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Full_Name'] = this.fullName;
    data['phone_Number'] = this.phoneNumber;
    data['appointment'] = this.appointment;
    data['age'] = this.age;
    data['appointment_type'] = this.appointmentType;
    data['Date_of_appointment'] = this.dateOfAppointment;
    data['location'] = this.location;
    data['page_source'] = this.pageSource;
    data['appointment_status'] = this.appointmentStatus;
    data['time_of_appointment'] = this.timeOfAppointment;
    data['therapist_id'] = this.therapistId;
    data['user_id'] = this.userId;
    data['file_path'] = this.filePath;
    data['rating_status'] = this.ratingStatus;
    return data;
  }
}
