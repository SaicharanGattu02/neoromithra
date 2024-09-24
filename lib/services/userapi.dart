import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../Model/BookApointmentModel.dart';
import '../Model/LoginModel.dart';
import '../Model/ProfileDetailsModel.dart';
import '../Model/RegisterModel.dart';


class Userapi {
  static String host="https://admin.neuromitra.com";
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
      String user_id
      ) async {
    try {
      final body = jsonEncode({
        'Full_Name': fname,
        'phone_Number': pnum,
        'appointment':appointment,
        'age': age,
        'appointment_type': appointment_type,
        'Date_of_appointment': Date_of_appointment,
        'location': location,
        'user_id': user_id,
      });
      print("Apointment data: $body");

      final url = Uri.parse("${host}/api/bookappointments?page_source=${page_source}&time_of_appointment=${time_of_appointment}");
      final headers = {
        'Content-Type': 'application/json'
      };
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
  }


  static Future<RegisterModel?> PostRegister(String name,String mail, String password,String phone,String fcm_token) async {
    try {
      Map<String, String> data = {
        "name":name,
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
      if (response!=null) {
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
      final url = Uri.parse("${host}/api/user-signin");
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
    try {
      final url = Uri.parse("${host}/api/get_user_details/${user_id}");
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response!=null) {
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
  }


  static Future<ProfileDetailsModel?>SubmitReview(String user_id) async {
    try {
      Map<String, dynamic> data = {
        "app_id":"11",
        "rating":3,
        "details":"text",
        "page_source":"Speech terapy"
      };
      final url = Uri.parse("${host}/api/create_review");
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data)
      );
      if (response!=null) {
        final jsonResponse = jsonDecode(response.body);
        print("SubmitReview Status:${response.body}");
        return ProfileDetailsModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<ProfileDetailsModel?> getbookinghistory(String user_id) async {
    try {
      final url = Uri.parse("${host}/api/get_user_booking_hisrory/${user_id}");
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response!=null) {
        final jsonResponse = jsonDecode(response.body);
        print("getbookinghistory Status:${response.body}");
        return ProfileDetailsModel.fromJson(jsonResponse);
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
