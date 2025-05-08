class ProfileDetailsModel {
  bool? status;
  Users? user;

  ProfileDetailsModel({this.status, this.user});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user =
    json['message'] != null ? new Users.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['message'] = this.user!.toJson();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  int? contact;
  String? emailVerifiedAt;
  String? refreshToken;
  String? webFcmToken;
  String? deviceFcmToken;
  String? role;
  String? gender;
  String? profilePic;
  String? state;
  String? city;
  String? country;
  String? postalcode;
  String? uniqueHostalId;
  String? emailOtp;
  String? expiredTime;
  int? deletedAt;
  String? createdAt;
  String? updatedAt;

  Users(
      {this.id,
        this.name,
        this.email,
        this.contact,
        this.emailVerifiedAt,
        this.refreshToken,
        this.webFcmToken,
        this.deviceFcmToken,
        this.role,
        this.gender,
        this.profilePic,
        this.state,
        this.city,
        this.country,
        this.postalcode,
        this.uniqueHostalId,
        this.emailOtp,
        this.expiredTime,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    emailVerifiedAt = json['email_verified_at'];
    refreshToken = json['refresh_token'];
    webFcmToken = json['web_fcm_token'];
    deviceFcmToken = json['device_fcm_token'];
    role = json['role'];
    gender = json['gender'];
    profilePic = json['profile_pic'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    postalcode = json['postalcode'];
    uniqueHostalId = json['unique_hostal_id'];
    emailOtp = json['email_otp'];
    expiredTime = json['expired_time'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['refresh_token'] = this.refreshToken;
    data['web_fcm_token'] = this.webFcmToken;
    data['device_fcm_token'] = this.deviceFcmToken;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['profile_pic'] = this.profilePic;
    data['state'] = this.state;
    data['city'] = this.city;
    data['country'] = this.country;
    data['postalcode'] = this.postalcode;
    data['unique_hostal_id'] = this.uniqueHostalId;
    data['email_otp'] = this.emailOtp;
    data['expired_time'] = this.expiredTime;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
