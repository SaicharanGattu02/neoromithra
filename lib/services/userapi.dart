import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:neuromithra/Model/PhonepeDetails.dart';
import 'package:neuromithra/Model/QuoteModel.dart';
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
import '../Model/TherapiesListModel.dart';
import '../utils/constants.dart';
import 'AuthService.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class Userapi {
  static final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: "https://api.neuromitra.com",
      baseUrl: "http://192.168.80.237:8000",
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
          if (e.response != null) {
            switch (e.response?.statusCode) {
              case 201:
                print("Unauthorized: Navigating to SignIn");
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Future.microtask(() {
                  navigatorKey.currentState
                      ?.pushNamedAndRemoveUntil('/login', (route) => false);
                });
                return;
              case 401:
                print("Unauthorized: Navigating to SignIn");
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Future.microtask(() {
                  navigatorKey.currentState
                      ?.pushNamedAndRemoveUntil('/login', (route) => false);
                });
                return;
              default:
                print("Error ${e.response?.statusCode}: ${e.response?.data}");
            }
          } else {
            print("Network Error: ${e.message}");
          }

          return handler.next(e);
        },
      ),
    );
  }

  static Future<bool> _refreshToken() async {
    try {
      final newToken = await AuthService.refreshToken();
      if (newToken != null) {
        print("Token refreshed successfully");
        return true;
      }
    } catch (e) {
      print("Token refresh failed: $e");
    }
    return false;
  }

  // Existing methods
  static Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      print("called get method");
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
      print("DioException occurred: ${error.message}");
      throw error;
    } else {
      print("Unexpected error: $error");
      throw Exception("Unexpected error occurred");
    }
  }

  // Converted Userapi methods
  static Future<PhonepeDetails?> getPhonepeDetails() async {
    try {
      final response = await _dio.get("/api/Phonepay");
      if (response.statusCode == 200) {
        print("getPhonepeDetails Status: ${response.data}");
        return PhonepeDetails.fromJson(response.data);
      } else {
        throw Exception("Failed to load Phonepe details");
      }
    } catch (e) {
      print("Error fetching Phonepe details: $e");
      return null;
    }
  }

  static Future<Map<String, List<AssessmentQuestion>>>
      fetchAdultQuestions() async {
    try {
      final response = await _dio.get("/api/list_of_questions_for_adults");
      if (response.statusCode == 200) {
        final data = response.data;
        Map<String, List<AssessmentQuestion>> parsedData = {};
        data['data'].forEach((key, value) {
          parsedData[key] = List<AssessmentQuestion>.from(
            value.map((q) => AssessmentQuestion.fromJson(q)),
          );
        });
        return parsedData;
      } else {
        throw Exception("Failed to load adult questions");
      }
    } catch (e) {
      print("Error fetching adult questions: $e");
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
      final response = await _dio.post("/api/save_assement", data: formData);
      if (response.statusCode == 200) {
        print("Success: ${response.data["message"]}");
        return response.data;
      } else {
        throw Exception("Submission failed: ${response.data["message"]}");
      }
    } catch (e) {
      print("Error submitting answers: $e");
      return {"status": false, "message": "Error submitting answers"};
    }
  }

  static Future<Map<String, List<AssessmentQuestion>>>
      fetchChildrenQuestions() async {
    try {
      final response = await _dio.get("/api/list_of_questions");
      if (response.statusCode == 200) {
        final data = response.data;
        Map<String, List<AssessmentQuestion>> parsedData = {};
        data['data'].forEach((key, value) {
          parsedData[key] = List<AssessmentQuestion>.from(
            value.map((q) => AssessmentQuestion.fromJson(q)),
          );
        });
        return parsedData;
      } else {
        throw Exception("Failed to load children questions");
      }
    } catch (e) {
      print("Error fetching children questions: $e");
      return {};
    }
  }

  static Future<String?> makeSOSCallApi(String loc) async {
    try {
      final response = await _dio.post(
        "/api/sos-call",
        data: {"location": loc},
      );
      if (response.statusCode == 200) {
        print("makeSOSCallApi Status: ${response.data}");
        return response.data["message"];
      } else if (response.statusCode == 401) {
        print("Unauthorized: ${response.data['error']}");
        return response.data["error"];
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
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
      final response =
          await _dio.post("/api/for_new_bookappointments", data: formData);
      if (response.statusCode == 200) {
        print("✅ Appointment Response: ${response.data}");
        return BookApointmentModel.fromJson(response.data);
      } else {
        print("❌ Failed to book appointment: ${response.statusCode}");
        print("Response: ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
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
      final response =
          await _dio.post("/api/for_exesting_bookappointments", data: formData);
      if (response.statusCode == 200) {
        print("✅ Existing Appointment Response: ${response.data}");
        return BookApointmentModel.fromJson(response.data);
      } else {
        print("❌ Failed to book existing appointment: ${response.statusCode}");
        print("Response: ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<RegisterModel?> postRegister(String name, String mail,
      String password, String phone, String fcmToken, String sosNumber) async {
    try {
      final response = await _dio.post(
        "/api/user/userregister",
        data: {
          "name": name,
          "email": mail,
          "password": password,
          "phone": phone,
          "fcm_token": fcmToken,
          "sos_1": sosNumber,
        },
      );
      if (response.statusCode == 200) {
        print("PostRegister Status: ${response.data}");
        return RegisterModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> postLogin(data) async {
    try {
      final response = await _dio.post("/api/mobile-login", data: data);
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

  static Future<Map<String, dynamic>?> postProfileDetails(String name,
      String email, String phone) async {
    try {
      final response = await _dio.post(
        "/api/users/update_user_details",
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        },
      );
      if (response.statusCode == 200) {
        print("postProfileDetails Status: ${response.data}");
        return {"message": response.data["message"]};
      } else if (response.statusCode == 401) {
        print("Unauthorized: ${response.data['error']}");
        return {"error": response.data["error"]};
      } else if (response.statusCode == 400) {
        print("postProfileDetails Error: ${response.data}");
        return response.data.containsKey("errors")
            ? {"error": response.data["errors"]}
            : {"error": "Bad request with status 400"};
      } else {
        print("Request failed with status: ${response.statusCode}");
        return {"error": "Request failed with status: ${response.statusCode}"};
      }
    } catch (e) {
      print("Error occurred: $e");
      return {"error": e.toString()};
    }
  }

  static Future<TherapiesListModel?> getTherapiesList() async {
    try {
      final response = await _dio.get("/api/users/guest-service?type=Therapy");
      if (response.statusCode == 200) {
        print("getprofiledetails Status: ${response.data}");
        return TherapiesListModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<TherapiesListModel?> getServiceDetails(String id) async {
    try {
      final response = await _dio.get("/api/users/guest-service/$id");
      if (response.statusCode == 200) {
        print("getTherapyDetails Status: ${response.data}");
        return TherapiesListModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<TherapiesListModel?> getCounsellingDetails(String id) async {
    try {
      final response = await _dio.get("/api/users/guest-service/$id");
      if (response.statusCode == 200) {
        print("getCounsellingDetails Status: ${response.data}");
        return TherapiesListModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<CounsellingsListModel?> getCounsellingsList() async {
    try {
      final response = await _dio.get("/api/users/guest-service?type=Counselling");
      if (response.statusCode == 200) {
        print("getCounsellingsList Status: ${response.data}");
        return CounsellingsListModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<ProfileDetailsModel?> getProfileDetails(String userId) async {
    try {
      final response = await _dio.get("/api/users/view-profile");
      if (response.statusCode == 200) {
        print("getprofiledetails Status: ${response.data}");
        return ProfileDetailsModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<ReviewSubmitModel?> submitReviewApi(
      String appId, String pageSource, String rating, String review) async {
    try {
      final response = await _dio.post(
        "/api/create_review",
        data: {
          "app_id": appId,
          "rating": rating,
          "details": review,
          "page_source": pageSource,
        },
      );
      if (response.statusCode == 200) {
        print("SubmitReview Status: ${response.data}");
        return ReviewSubmitModel.fromJson(response.data);
      } else {
        print("Error: ${response.statusCode} ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<BookingHistoryModel?> getBookingHistory() async {
    try {
      final response = await _dio.get("/api/get_user_booking_hisrory");
      if (response.statusCode == 200) {
        print("getbookinghistory Status: ${response.data}");
        return BookingHistoryModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<PreviousBookingModel?> getPreviousBookingHistory() async {
    try {
      final response = await _dio.get("/api/get_user_booking_hisrory");
      if (response.statusCode == 200) {
        print("getbookinghistory Status: ${response.data}");
        return PreviousBookingModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<LoginModel?> updateRefreshToken() async {
    try {
      final response = await _dio.post("/api/refreshToken");
      if (response.statusCode == 200) {
        print("UpdateRefreshToken response: ${response.data}");
        return LoginModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<ReviewListModel?> getReviewList(String pageSource) async {
    try {
      final response = await _dio.get("/api/get_review/$pageSource");
      if (response.statusCode == 200) {
        print("getreviewlist response: ${response.data}");
        return ReviewListModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
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
      final response =
          await _dio.post("/api/update_profile_image", data: formData);
      if (response.statusCode == 200) {
        // Assuming response matches LoginModel structure
        return LoginModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<AddAddressModel?> addAddressApi(Map<String,dynamic>data) async {
    try {
      final response = await _dio.post("/api/add_user_address",data: data);
      if (response.statusCode == 200) {
        print("AddAddressApi Response: ${response.data}");
        return AddAddressModel.fromJson(response.data);
      } else {
        print("Error: ${response.statusCode} ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<AddAddressModel?> editAddressApi(Map<String,dynamic>data, String addressId) async {
    try {
      final response = await _dio.post("/api/update_user_address/$addressId",data: data);
      if (response.statusCode == 200) {
        print("EditAddressApi Response: ${response.data}");
        return AddAddressModel.fromJson(response.data);
      } else {
        print("Error: ${response.statusCode} ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<AddressListModel?> getAddressList() async {
    try {
      final response = await _dio.get("/api/get_user_address_details");
      if (response.statusCode == 200) {
        print("getaddresslist response: ${response.data}");
        return AddressListModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<String?> downloadScriptApi() async {
    try {
      final response = await _dio.get("/api/downloadfile/79");
      if (response.statusCode == 200) {
        print("downloadscriptapi response: ${response.data}");
        return response.data.toString(); // Assuming it's a string response
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<PreviousBookingModel?> getPreviousBookings(
      String pageSource) async {
    try {
      final response =
          await _dio.get("/api/check_previous_bookings/$pageSource");
      if (response.statusCode == 200) {
        print("getpreviousbookings response: ${response.data}");
        return PreviousBookingModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<BehaviouralTrackingModel?> getBehaviouralList(
      String id, String pageSource) async {
    try {
      final response =
          await _dio.get("/api/get_therapy_traking/$id/$pageSource");
      if (response.statusCode == 200) {
        print("getbehaviourallist response: ${response.data}");
        return BehaviouralTrackingModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<QuoteModel?> getQuotes() async {
    try {
      final response = await _dio.get("/api/users/quatations");
      if (response.statusCode == 200) {
        print("getquotes response: ${response.data}");
        return QuoteModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<FeedbackHelathModel?> postHealthFeedback(String msg) async {
    try {
      final response = await _dio.post(
        "/api/users/daily-feedback",
        data: {"message": msg},
      );
      if (response.statusCode == 200) {
        print("posthelathFeedback response: ${response.data}");
        return FeedbackHelathModel.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }
}
