import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:neuromithra/Model/ChildListModel.dart';
import 'package:neuromithra/Model/PhonepeDetails.dart';
import 'package:neuromithra/Model/QuoteModel.dart';
import 'package:neuromithra/Model/SuccessModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/AddAddressModel.dart';
import '../Model/AddressListModel.dart';
import '../Model/AssessmentQuestion.dart';
import '../Model/BehaviouralTrackingModel.dart';
import '../Model/BookApointmentModel.dart';
import '../Model/BookingHistoryModel.dart';
import '../Model/CounsellingsListModel.dart';
import '../Model/FeedbackHelathModel.dart';
import '../Model/LoginModel.dart';
import '../Model/PreviousBookingModel.dart';
import '../Model/ProfileDetailsModel.dart';
import '../Model/RegisterModel.dart';
import '../Model/ReviewListModel.dart';
import '../Model/ReviewSubmitModel.dart';
import '../Model/SignInMobileModel.dart';
import '../Model/TherapiesListModel.dart';
import '../api_endpoint_urls.dart';
import '../utils/constants.dart';
import 'AuthService.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class Userapi {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIEndpointUrls.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  static void setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await AuthService.getAccessToken();
          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 201 || e.response?.statusCode == 401) {
            debugPrint("Token expired or unauthorized: ${e.response?.statusCode}");
            // If refresh or retry fails, clear prefs and navigate to login
            debugPrint("Navigating to SignIn");
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            navigatorKey.currentState
                ?.pushNamedAndRemoveUntil('/login', (route) => false);
            return handler.reject(e);
          } else {
            debugPrint("Error ${e.response?.statusCode}: ${e.response?.data}");
            return handler.next(e);
          }
        },
      ),
    );
  }

  static Future<bool> _refreshToken() async {
    try {
      final newToken = await AuthService.refreshToken();
      if (newToken != null) {
        debugPrint("Token refreshed successfully");
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Token refresh failed: $e");
      return false;
    }
  }

  static Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      debugPrint("called get method");
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Response _handleError(dynamic error) {
    if (error is DioException) {
      debugPrint("DioException occurred: ${error.message}");
      throw error;
    } else {
      debugPrint("Unexpected error: $error");
      throw Exception("Unexpected error occurred");
    }
  }

  static Future<PhonepeDetails?> getPhonepeDetails() async {
    try {
      final response = await get("/api/Phonepay");
      if (response.statusCode == 200) {
        debugPrint("getPhonepeDetails Status: ${response.data}");
        return PhonepeDetails.fromJson(response.data);
      }
      throw Exception("Failed to load Phonepe details");
    } catch (e) {
      debugPrint("Error fetching Phonepe details: $e");
      return null;
    }
  }

  static Future<Map<String, List<AssessmentQuestion>>> fetchAdultQuestions() async {
    try {
      final response = await get("/api/list_of_questions_for_adults");
      if (response.statusCode == 200) {
        final data = response.data;
        Map<String, List<AssessmentQuestion>> parsedData = {};
        data['data'].forEach((key, value) {
          parsedData[key] = List<AssessmentQuestion>.from(
            value.map((q) => AssessmentQuestion.fromJson(q)),
          );
        });
        return parsedData;
      }
      throw Exception("Failed to load adult questions");
    } catch (e) {
      debugPrint("Error fetching adult questions: $e");
      return {};
    }
  }

  static Future<Map<String, dynamic>> submitChildrenAnswers(
      Map<String, dynamic> data, String role) async {
    try {
      final formData = FormData.fromMap({
        'data': jsonEncode(data),
        'role': role,
      });
      final response = await post("/api/save_assement", data: formData);
      if (response.statusCode == 200) {
        debugPrint("Success: ${response.data["message"]}");
        return response.data;
      }
      throw Exception("Submission failed: ${response.data["message"]}");
    } catch (e) {
      debugPrint("Error submitting answers: $e");
      return {"status": false, "message": "Error submitting answers"};
    }
  }

  static Future<Map<String, List<AssessmentQuestion>>> fetchChildrenQuestions() async {
    try {
      final response = await get("/api/list_of_questions");
      if (response.statusCode == 200) {
        final data = response.data;
        Map<String, List<AssessmentQuestion>> parsedData = {};
        data['data'].forEach((key, value) {
          parsedData[key] = List<AssessmentQuestion>.from(
            value.map((q) => AssessmentQuestion.fromJson(q)),
          );
        });
        return parsedData;
      }
      throw Exception("Failed to load children questions");
    } catch (e) {
      debugPrint("Error fetching children questions: $e");
      return {};
    }
  }

  static Future<String?> makeSOSCallApi(String loc) async {
    try {
      final response = await post(
        "/api/sos-call",
        data: {"location": loc},
      );
      if (response.statusCode == 200) {
        debugPrint("makeSOSCallApi Status: ${response.data}");
        return response.data["message"];
      } else if (response.statusCode == 401) {
        debugPrint("Unauthorized: ${response.data['error']}");
        return response.data["error"];
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<BookApointmentModel?> newApointment(
      String fname,
      String pnum,
      String appointment,
      String age,
      String appointmentType,
      String dateOfAppointment,
      String location,
      String pageSource,
      String timeOfAppointment,
      String userId,
      Map<String, dynamic> orderData) async {
    try {
      final formData = FormData.fromMap({
        'Full_Name': fname,
        'phone_Number': pnum,
        'appointment': appointment,
        'age': age,
        'appointment_type': appointmentType,
        'Date_of_appointment': dateOfAppointment,
        'location': location,
        'page_source': pageSource,
        'time_of_appointment': timeOfAppointment,
        'payment_json': jsonEncode(orderData),
      });
      final response = await post("/api/for_new_bookappointments", data: formData);
      if (response.statusCode == 200) {
        debugPrint("✅ Appointment Response: ${response.data}");
        return BookApointmentModel.fromJson(response.data);
      }
      debugPrint("❌ Failed to book appointment: ${response.statusCode}");
      debugPrint("Response: ${response.data}");
      return null;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  static Future<BookApointmentModel?> existApointment(
      String fname,
      String pnum,
      String appointment,
      String age,
      String appointmentType,
      String dateOfAppointment,
      String location,
      String pageSource,
      String timeOfAppointment,
      String userId,
      String patientId,
      Map<String, dynamic> orderData) async {
    try {
      final formData = FormData.fromMap({
        'Full_Name': fname,
        'phone_Number': pnum,
        'appointment': appointment,
        'age': age,
        'appointment_type': appointmentType,
        'Date_of_appointment': dateOfAppointment,
        'location': location,
        'page_source': pageSource,
        'time_of_appointment': timeOfAppointment,
        'patient_id': patientId,
        'payment_json': jsonEncode(orderData),
      });
      final response = await post("/api/for_exesting_bookappointments", data: formData);
      if (response.statusCode == 200) {
        debugPrint("✅ Existing Appointment Response: ${response.data}");
        return BookApointmentModel.fromJson(response.data);
      }
      debugPrint("❌ Failed to book existing appointment: ${response.statusCode}");
      debugPrint("Response: ${response.data}");
      return null;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  static Future<RegisterModel?> postRegister(data) async {
    try {
      final response = await post(
        "/api/user/userregister",
        data: data
      );
      if (response.statusCode == 200) {
        debugPrint("PostRegister Status: ${response.data}");
        return RegisterModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> postLogin(dynamic data) async {
    try {
      final response = await post(APIEndpointUrls.userLogin, data: data);
      if (response.statusCode == 200) {
        debugPrint("PostLogin Status: ${response.data}");
        return {
          "access_token": response.data["access_token"],
          "token_type": response.data["token_type"],
          "expires_in": response.data["expires_in"],
        };
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        debugPrint("Unauthorized: ${response.data['error']}");
        return {
          "error": response.data["error"],
          "status": response.data["status"],
        };
      }
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<SignInMobileModel?> postLoginWithMobile(data) async {
    try {
      final response = await _dio.post(APIEndpointUrls.LoginWithMobile, data: data);
      if (response.statusCode == 200) {
        print("postLoginWithMobile Status: ${response.data}");
        return SignInMobileModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyOtp(data)  async {
    try {
      final response = await _dio.post(APIEndpointUrls.userVerifyOtp, data: data);
      if (response.statusCode == 200) {
        print("PostLogin Status: ${response.data}");
        return {
          "access_token": response.data["access_token"],
          "token_type": response.data["token_type"],
          "expires_in": response.data["expires_in"],
        };
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print("Unauthorized: ${response.data['error']}");
        return {
          "error": response.data["error"],
          "status": response.data["status"],
        };
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<Map<String, dynamic>?> updateProfileDetails(
     formData) async {
    try {
      final response = await post(
        APIEndpointUrls.updateprofileDetails,
        data: formData,
      );
      if (response.statusCode == 200) {
        debugPrint("postProfileDetails Status: ${response.data}");
        return {"message": response.data["message"]};
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return {"error": "Request failed with status: ${response.statusCode}"};
    } catch (e) {
      debugPrint("Error occurred: $e");
      return {"error": e.toString()};
    }
  }

  static Future<TherapiesListModel?> getTherapiesList() async {
    try {
      final response = await get("${APIEndpointUrls.serviceList}?type=Therapy");
      if (response.statusCode == 200) {
        debugPrint("getTherapiesList Status: ${response.data}");
        return TherapiesListModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<TherapiesListModel?> getServiceDetails(String id) async {
    try {
      final response = await get("${APIEndpointUrls.guestServiceDetails}/$id");
      if (response.statusCode == 200) {
        debugPrint("getServiceDetails Status: ${response.data}");
        return TherapiesListModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }


  static Future<CounsellingsListModel?> getCounsellingsList() async {
    try {
      final response = await get("${APIEndpointUrls.guestServiceDetails}?type=Counselling");
      if (response.statusCode == 200) {
        debugPrint("getCounsellingsList Status: ${response.data}");
        return CounsellingsListModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<ProfileDetailsModel?> getProfileDetails(String userId) async {
    try {
      final response = await get("${APIEndpointUrls.getprofileDetails}");
      if (response.statusCode == 200) {
        debugPrint("getProfileDetails Status: ${response.data}");
        return ProfileDetailsModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<SuccessModel?> addChild(Map<String, dynamic> data) async {
    try {
      final response = await post("${APIEndpointUrls.addChild}");
      if (response.statusCode == 200) {
        debugPrint("addchild Status: ${response.data}");
        return SuccessModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<SuccessModel?> editChild(Map<String, dynamic> data,String id) async {
    try {
      final response = await put("${APIEndpointUrls.editChild}/${id}");
      if (response.statusCode == 200) {
        debugPrint("editchild Status: ${response.data}");
        return SuccessModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }


  static Future<SuccessModel?> deleteChild(String id) async {
    try {
      final response = await delete("${APIEndpointUrls.deleteChild}/${id}");
      if (response.statusCode == 200) {
        debugPrint("deleteChild Status: ${response.data}");
        return SuccessModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<ChildListModel?> getChildList() async {
    try {
      final response = await get("${APIEndpointUrls.childList}");
      if (response.statusCode == 200) {
        debugPrint("getChildList Status: ${response.data}");
        return ChildListModel.fromJson(response.data);
      }
      debugPrint("Request failed with status:${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }


  static Future<ChildListModel?> getChildDetails(String id) async {
    try {
      final response = await get("${APIEndpointUrls.childDetails}/${id}");
      if (response.statusCode == 200) {
        debugPrint("getChildDetails Status: ${response.data}");
        return ChildListModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<ReviewSubmitModel?> submitReviewApi(
      String appId, String pageSource, String rating, String review) async {
    try {
      final response = await post(
        "${APIEndpointUrls.submitReview}",
        data: {
          "app_id": appId,
          "rating": rating,
          "details": review,
          "page_source": pageSource,
        },
      );
      if (response.statusCode == 200) {
        debugPrint("submitReviewApi Status: ${response.data}");
        return ReviewSubmitModel.fromJson(response.data);
      }
      debugPrint("Error: ${response.statusCode} ${response.data}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<BookingHistoryModel?> getBookingHistory() async {
    try {
      final response = await get("${APIEndpointUrls.bookingHistory}");
      if (response.statusCode == 200) {
        debugPrint("getBookingHistory Status: ${response.data}");
        return BookingHistoryModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<SuccessModel?> createBooking(Map<String,dynamic> data) async {
    try {
      final response = await post("/api/users/create-appointment-request",data: data);
      if (response.statusCode == 200) {
        debugPrint("createBooking Status: ${response.data}");
        return SuccessModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<PreviousBookingModel?> getPreviousBookingHistory() async {
    try {
      final response = await get("${APIEndpointUrls.bookingHistory}");
      if (response.statusCode == 200) {
        debugPrint("getPreviousBookingHistory Status: ${response.data}");
        return PreviousBookingModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<LoginModel?> updateRefreshToken() async {
    try {
      final response = await post("${APIEndpointUrls.updateRefreshToken}");
      if (response.statusCode == 200) {
        debugPrint("updateRefreshToken response: ${response.data}");
        return LoginModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<ReviewListModel?> getReviewList(String pageSource) async {
    try {
      final response = await get("${APIEndpointUrls.getReviewList}/$pageSource");
      if (response.statusCode == 200) {
        debugPrint("getReviewList response: ${response.data}");
        return ReviewListModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<LoginModel?> uploadImage(File image) async {
    try {
      final mimeType = lookupMimeType(image.path);
      final formData = FormData.fromMap({
        'user_profile': await MultipartFile.fromFile(
          image.path,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ),
      });
      final response = await post("${APIEndpointUrls.updateProfileImage}", data: formData);
      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<AddAddressModel?> addAddressApi(Map<String, dynamic> data) async {
    try {
      final response = await post("${APIEndpointUrls.addAddress}", data: data);
      if (response.statusCode == 200) {
        debugPrint("addAddressApi Response: ${response.data}");
        return AddAddressModel.fromJson(response.data);
      }
      debugPrint("Error: ${response.statusCode} ${response.data}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<AddAddressModel?> editAddressApi(
      Map<String, dynamic> data, String addressId) async {
    try {
      final response = await put("${APIEndpointUrls.updateAddress}/$addressId", data: data);
      if (response.statusCode == 200) {
        debugPrint("editAddressApi Response: ${response.data}");
        return AddAddressModel.fromJson(response.data);
      }
      debugPrint("Error: ${response.statusCode} ${response.data}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<AddressListModel?> getAddressList() async {
    try {
      final response = await get("${APIEndpointUrls.getAddress}");
      if (response.statusCode == 200) {
        debugPrint("getAddressList response: ${response.data}");
        return AddressListModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<String?> downloadScriptApi() async {
    try {
      final response = await get("${APIEndpointUrls.downloadScriptAPi}/79");
      if (response.statusCode == 200) {
        debugPrint("downloadScriptApi response: ${response.data}");
        return response.data.toString();
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<PreviousBookingModel?> getPreviousBookings(String pageSource) async {
    try {
      final response = await get("${APIEndpointUrls.checkPreviousBooking}/$pageSource");
      if (response.statusCode == 200) {
        debugPrint("getPreviousBookings response: ${response.data}");
        return PreviousBookingModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<BehaviouralTrackingModel?> getBehaviouralList(
      String id, String pageSource) async {
    try {
      final response = await get("${APIEndpointUrls.getTheraphyTracking}/$id/$pageSource");
      if (response.statusCode == 200) {
        debugPrint("getBehaviouralList response: ${response.data}");
        return BehaviouralTrackingModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<QuoteModel?> getQuotes() async {
    try {
      final response = await get("${APIEndpointUrls.quotes}");
      if (response.statusCode == 200) {
        debugPrint("getQuotes response: ${response.data}");
        return QuoteModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }

  static Future<FeedbackHelathModel?> postHealthFeedback(String msg) async {
    try {
      final response = await post(
        "${APIEndpointUrls.dailyFeedBack}",
        data: {"message": msg},
      );
      if (response.statusCode == 200) {
       debugPrint("postHealthFeedback response: ${response.data}");
        return FeedbackHelathModel.fromJson(response.data);
      }
      debugPrint("Request failed with status: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return null;
    }
  }
}
