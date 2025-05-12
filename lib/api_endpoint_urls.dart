class APIEndpointUrls {
  // static const String baseUrl = 'https://api.ridev.in/';
  static const String baseUrl = 'http://192.168.80.237:8000/';

  static const String apiUrl = 'api/';
  static const String userUrl = 'api/users/';


  static const String userLogin = '${apiUrl}mobile-login';
  static const String LoginWithMobile = '${apiUrl}/login-otp';
  static const String userVerifyOtp = '${apiUrl}/verify-login-otp';
  static const String updateprofileDetails = '${userUrl}profile-update';
  static const String serviceList = '${userUrl}guest-service';
  static const String guestServiceDetails = '${userUrl}guest-service';
  static const String getprofileDetails = '${userUrl}view-profile';

  static const String addChild ='${userUrl}add-new-child';
  static const String editChild ='${userUrl}edit-child';
  static const String deleteChild ='${userUrl}delete-child';
  static const String childList='${userUrl}get-child-details';
  static const String childDetails ='${userUrl}get-child-details';


  static const String addAddress ='${apiUrl}create-address';
  static const String updateAddress ='${apiUrl}update-address';
  static const String getAddress ='${apiUrl}view-address';
  static const String deleteAddress ='${apiUrl}delete-address';


  static const String submitReview ='${apiUrl}create_review';
  static const String bookingHistory ='${apiUrl}get_user_booking_hisrory';
  static const String previousBookingHistory ='${apiUrl}get_user_booking_hisrory';
  static const String updateRefreshToken ='${apiUrl}refreshToken';
  static const String getReviewList ='${apiUrl}get_review';
  static const String updateProfileImage ='${apiUrl}update_profile_image';
  static const String downloadScriptAPi ='${apiUrl}downloadfile';
  static const String checkPreviousBooking ='${apiUrl}check_previous_bookings';
  static const String getTheraphyTracking ='${apiUrl}get_therapy_traking';
  static const String quotes ='${userUrl}quatations';
  static const String dailyFeedBack ='${userUrl}daily-feedback';


}
