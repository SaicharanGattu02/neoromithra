class ProfileDetailsModel {
  User? user;
  HealthFeedback? healthFeedback;

  ProfileDetailsModel({this.user, this.healthFeedback});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    healthFeedback = json['health_feedback'] != null
        ? new HealthFeedback.fromJson(json['health_feedback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.healthFeedback != null) {
      data['health_feedback'] = this.healthFeedback!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? phone;
  int? sos1;
  int? sos2;
  int? sos3;
  int? userType;
  String? userProfile;
  String? fcmToken;
  String? addressId;
  String? createdAt;
  String? updatedAt;
  int? code;
  String? codeexp;
  int? codestatus;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.sos1,
        this.sos2,
        this.sos3,
        this.userType,
        this.userProfile,
        this.fcmToken,
        this.addressId,
        this.createdAt,
        this.updatedAt,
        this.code,
        this.codeexp,
        this.codestatus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    sos1 = json['sos_1'];
    sos2 = json['sos_2'];
    sos3 = json['sos_3'];
    userType = json['user_type'];
    userProfile = json['user_profile'];
    fcmToken = json['fcm_token'];
    addressId = json['address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    code = json['code'];
    codeexp = json['codeexp'];
    codestatus = json['codestatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['sos_1'] = this.sos1;
    data['sos_2'] = this.sos2;
    data['sos_3'] = this.sos3;
    data['user_type'] = this.userType;
    data['user_profile'] = this.userProfile;
    data['fcm_token'] = this.fcmToken;
    data['address_id'] = this.addressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['code'] = this.code;
    data['codeexp'] = this.codeexp;
    data['codestatus'] = this.codestatus;
    return data;
  }
}

class HealthFeedback {
  bool? status;

  HealthFeedback({this.status});

  HealthFeedback.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
