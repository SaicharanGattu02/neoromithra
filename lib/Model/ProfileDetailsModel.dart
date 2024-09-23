class ProfileDetailsModel {
  ProfilePicture? profilePicture; // Changed to single ProfilePicture
  bool? status;

  ProfileDetailsModel({this.profilePicture, this.status});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['profile_picture'] != null && json['profile_picture'].isNotEmpty) {
      profilePicture = ProfilePicture.fromJson(json['profile_picture'][0]); // Get the first profile picture
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.profilePicture != null) {
      data['profile_picture'] = this.profilePicture!.toJson(); // Convert the single profile picture to JSON
    }
    data['status'] = this.status;
    return data;
  }
}

class ProfilePicture {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt; // Changed to dynamic to handle Null
  int? phone;
  int? userType;
  String? userProfile;
  dynamic fcmToken; // Changed to dynamic to handle Null
  String? createdAt;
  String? updatedAt;

  ProfilePicture({
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

  ProfilePicture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    userType = json['user_type'];
    userProfile = json['user_profile'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['user_type'] = this.userType;
    data['user_profile'] = this.userProfile;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
