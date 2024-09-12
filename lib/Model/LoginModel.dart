class LoginModel {
  UserDetails? userDetails;
  int? userType;

  LoginModel({this.userDetails, this.userType});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['user_type'] = this.userType;
    return data;
  }
}

class UserDetails {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? phone;
  int? userType;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.userType,
        this.createdAt,
        this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
