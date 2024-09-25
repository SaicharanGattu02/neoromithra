import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../Model/BookApointmentModel.dart';
import '../Model/BookingHistoryModel.dart';
import '../Model/LoginModel.dart';
import '../Model/ProfileDetailsModel.dart';
import '../Model/RegisterModel.dart';
import '../Model/ReviewListModel.dart';
import '../Model/ReviewSubmitModel.dart';
import 'other_services.dart';

class Userapi {
  static String host = "https://admin.neuromitra.com";

  static Future<BookApointmentModel?> Apointment(
      String fname,
      String pnum,
      String appointment,
      String age,
      String appointment_type,
      String Date_of_appointment,
      String location,
      String page_source,
      String time_of_appointment,
      String user_id) async {
    if (await CheckHeaderValidity()) {
      try {
        final body = jsonEncode({
          'Full_Name': fname,
          'phone_Number': pnum,
          'appointment': appointment,
          'age': age,
          'appointment_type': appointment_type,
          'Date_of_appointment': Date_of_appointment,
          'location': location,
          'user_id': user_id,
        });
        print("Apointment data: $body");

        final url = Uri.parse(
            "${host}/api/bookappointments?page_source=${page_source}&time_of_appointment=${time_of_appointment}");
        final headers = await getheader();
        final response = await http.post(
          url,
          headers: headers,
          body: body,
        );
        final jsonResponse = jsonDecode(response.body);
        print("Apointment Status:${response.body}");
        return BookApointmentModel.fromJson(jsonResponse);
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    }else{
      return null;
    }
  }

  static Future<RegisterModel?> PostRegister(String name, String mail,
      String password, String phone, String fcm_token) async {
    try {
      Map<String, String> data = {
        "name": name,
        "email": mail,
        "password": password,
        "phone": phone,
        "fcm_token": fcm_token
      };
      final url = Uri.parse("${host}/api/user-signup");
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data),
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("PostRegister Status:${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<LoginModel?> PostLogin(String mail, String password) async {
    try {
      Map<String, String> data = {
        "email": mail,
        "password": password,
      };
      print("PostLogin: $data");
      final url = Uri.parse("${host}/api/user/login");
      print("PostLogin : $url");
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data),
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("PostLogin Status:${response.body}");
        return LoginModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<ProfileDetailsModel?> getprofiledetails(String user_id) async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/get_user_details/${user_id}");
        final headers = await getheader1();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getprofiledetails Status:${response.body}");
          return ProfileDetailsModel.fromJson(jsonResponse);
        } else {
          print("Request failed with status: ${response.statusCode}");
          return null;
        }
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    }else{
      return null;
    }
  }

  static Future<ReviewSubmitModel?> SubmitReviewApi(String appid, String page_source, String rating, String review) async {
    if (await CheckHeaderValidity()) {
      try {
        // Prepare the data
        Map<String, String> data = {
          "app_id": appid,
          "rating": rating,
          "details": review,
          "page_source": page_source,
        };
        print("SubmitReviewApi: ${data}");

        final url = Uri.parse("$host/api/create_review");
        final headers = await getheader2(); // Assuming this fetches headers with Authorization

        // Send the POST request
        final response = await http.post(
          url,
          headers: headers,
          body: data, // Use data directly for x-www-form-urlencoded
        );

        // Check the response status
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          print("SubmitReview Status: ${response.body}");
          return ReviewSubmitModel.fromJson(jsonResponse);; // Return as string or adjust as needed
        } else {
          print("Error: ${response.statusCode} ${response.body}");
          return null;
        }
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<BookingHistoryModel?> getbookinghistory() async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/get_user_booking_hisrory");
        final headers = await getheader();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getbookinghistory Status:${response.body}");
          return BookingHistoryModel.fromJson(jsonResponse);
        } else {
          print("Request failed with status: ${response.statusCode}");
          return null;
        }
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<LoginModel?> UpdateRefreshToken() async {
    try {
      final url = Uri.parse("${host}/api/refreshToken");
      final headers = await getheader();
      final response = await http.post(
        url,
        headers: headers
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("UpdateRefreshToken response:${response.body}");
        return LoginModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<ReviewListModel?> getreviewlist() async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/get_review/test");
        final headers = await getheader();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getreviewlist response:${response.body}");
          return ReviewListModel.fromJson(jsonResponse);
        } else {
          print("Request failed with status: ${response.statusCode}");
          return null;
        }
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    } else {
      return null;
    }
  }

}
