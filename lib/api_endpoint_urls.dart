class APIEndpointUrls {
  // static const String baseUrl = 'https://api.ridev.in/';
  static const String baseUrl = 'http://192.168.80.237:8000/';

  static const String apiUrl = 'api/';
  static const String userUrl = 'api/users/';


  static const String user_register = '${apiUrl}register-user';
  static const String login_with_username = '${apiUrl}mobile-login';
  static const String login_with_mobile = '${apiUrl}/login-otp';
  static const String verify_login_otp = '${apiUrl}/verify-login-otp';
  static const String updateprofileDetails = '${userUrl}profile-update';
  static const String serviceList = '${userUrl}guest-service';
  static const String guestServiceDetails = '${userUrl}guest-service';
  static const String getprofileDetails = '${userUrl}view-profile';

  static const String addChild ='${userUrl}add-new-child';
  static const String editChild ='${userUrl}edit-child';
  static const String deleteChild ='${userUrl}delete-child';
  static const String childList='${userUrl}get-child-details';
  static const String childDetails ='${userUrl}get-child-details';


  static const String addAddress ='${userUrl}create-address';
  static const String updateAddress ='${userUrl}update-address';
  static const String getAddress ='${userUrl}view-address';
  static const String deleteAddress ='${userUrl}delete-address';


  static const String submitReview ='${apiUrl}create_review';
  static const String bookingHistory ='${userUrl}view-appointments';
  static const String sessionsByID ='${userUrl}appointments_by_id';
  static const String session_tracking ='${userUrl}session-tracking';
  static const String updateRefreshToken ='${apiUrl}refreshToken';
  static const String getReviewList ='${apiUrl}get_review';
  static const String updateProfileImage ='${apiUrl}update_profile_image';
  static const String downloadScriptAPi ='${apiUrl}downloadfile';
  static const String checkPreviousBooking ='${apiUrl}check_previous_bookings';
  static const String getTheraphyTracking ='${apiUrl}get_therapy_traking';
  static const String quotes ='${userUrl}quatations';
  static const String dailyFeedBack ='${userUrl}daily-feedback';
  static const String upcomingAppointment ='${userUrl}upcoming-appointments';
  static const String bookAppointment ='${userUrl}create-appointment-request';


}
