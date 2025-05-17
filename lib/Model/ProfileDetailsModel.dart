class ProfileDetailsModel {
  bool? status;
  User? user;
  HealthFeedback? healthFeedback;

  ProfileDetailsModel({this.status, this.user, this.healthFeedback});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['message'] != null ? User.fromJson(json['message']) : null;
    healthFeedback = json['health_feedback'] != null
        ? HealthFeedback.fromJson(json['health_feedback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (user != null) {
      data['message'] = user!.toJson();
    }
    if (healthFeedback != null) {
      data['health_feedback'] = healthFeedback!.toJson();
    }
    return data;
  }
}

class User {
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
  String? profilePicUrl;

  User({
    this.id,
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
    this.updatedAt,
    this.profilePicUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
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
    profilePicUrl = json['profile_pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact'] = contact;
    data['email_verified_at'] = emailVerifiedAt;
    data['refresh_token'] = refreshToken;
    data['web_fcm_token'] = webFcmToken;
    data['device_fcm_token'] = deviceFcmToken;
    data['role'] = role;
    data['gender'] = gender;
    data['profile_pic'] = profilePic;
    data['state'] = state;
    data['city'] = city;
    data['country'] = country;
    data['postalcode'] = postalcode;
    data['unique_hostal_id'] = uniqueHostalId;
    data['email_otp'] = emailOtp;
    data['expired_time'] = expiredTime;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_pic_url'] = profilePicUrl;
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
    return {
      'status': status,
    };
  }
}
