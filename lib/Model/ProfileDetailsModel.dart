class ProfileDetailsModel {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? phone;
  int? sos1;
  int? sos2;
  int? sos3;
  int? userType;
  Null? userProfile;
  String? fcmToken;
  Null? addressId;
  String? createdAt;
  String? updatedAt;
  Null? code;
  Null? codeexp;
  int? codestatus;

  ProfileDetailsModel(
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

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
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
