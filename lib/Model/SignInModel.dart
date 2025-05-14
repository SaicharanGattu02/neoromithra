class SignInModel {
  bool? status;
  String? message;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? role;
  int? expiresIn;

  SignInModel(
      {this.status,
        this.accessToken,
        this.message,
        this.refreshToken,
        this.tokenType,
        this.role,
        this.expiresIn});

  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    role = json['role'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    data['role'] = this.role;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
