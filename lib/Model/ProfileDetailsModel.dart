class ProfileDetailsModel {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt; // Adjusted type for date
  int? phone;
  int? userType;
  String? userProfile; // Adjust as needed
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  ProfileDetailsModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.userType,
    this.userProfile,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null;
    phone = json['phone'];
    userType = json['user_type'];
    userProfile = json['user_profile'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'phone': phone,
      'user_type': userType,
      'user_profile': userProfile,
      'fcm_token': fcmToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
