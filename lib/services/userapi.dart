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
import 'AuthService.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

// class Userapi {
//   static String host = "https://api.neuromitra.com";
//   // static String host = "http://192.168.0.61:8080";
//   static Future<PhonepeDetails?> getPhonepeDetails() async {
//     try {
//       final headers = await getheader3();
//       final response = await http.get(
//         Uri.parse("${host}/api/Phonepay"),
//         headers: headers, // Authorization header
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         print("getPhonepeDetails Status:${response.body}");
//         return PhonepeDetails.fromJson(jsonResponse);
//       } else {
//         throw Exception("Failed to load questions");
//       }
//     } catch (e) {
//       print("Error fetching questions: $e");
//       return null;
//     }
//   }
//
//   // static Future<Map<String, dynamic>?> makePayment() async {
//   //   var url = Uri.parse('http://192.168.0.61:8080/api/phonepe/pay');
//   //
//   //   var request = http.MultipartRequest('POST', url)
//   //     ..headers.addAll({
//   //       'Cookie': 'XSRF-TOKEN=your_xsrf_token_here; neuromitra_session=your_session_token_here'
//   //     })
//   //     ..fields['amount'] = '1';
//   //
//   //   try {
//   //     var response = await request.send();
//   //     var responseData = await response.stream.bytesToString();
//   //
//   //     if (response.statusCode == 200) {
//   //       return jsonDecode(responseData); // Returning API response as a Map
//   //     } else {
//   //       return {'success': false, 'message': 'Request failed with status ${response.statusCode}'};
//   //     }
//   //   } catch (e) {
//   //     return {'success': false, 'message': e.toString()};
//   //   }
//   // }
//
//   static Future<Map<String, List<AssessmentQuestion>>>
//       fetchAdultQuestions() async {
//     try {
//       final headers = await getheader3();
//       final response = await http.get(
//         Uri.parse("${host}/api/list_of_questions_for_adults"),
//         headers: headers, // Authorization header
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         // Parse API response into model
//         Map<String, List<AssessmentQuestion>> parsedData = {};
//         data['data'].forEach((key, value) {
//           parsedData[key] = List<AssessmentQuestion>.from(
//             value.map((q) => AssessmentQuestion.fromJson(q)),
//           );
//         });
//         return parsedData;
//       } else {
//         throw Exception("Failed to load questions");
//       }
//     } catch (e) {
//       print("Error fetching questions: $e");
//       return {}; // Return empty map in case of error
//     }
//   }
//
//   static Future<Map<String, dynamic>> submitChildrenAnswers(
//       Map<String, dynamic> data, role) async {
//     try {
//       final headers = await getheader3();
//
//       var request =
//           http.MultipartRequest('POST', Uri.parse("${host}/api/save_assement"));
//
//       // Add Authorization Header
//       request.headers.addAll(headers);
//
//       // Convert JSON to String and send it as a form field
//       request.fields['data'] = jsonEncode(data);
//       request.fields['role'] = role;
//
//       // Send request
//       var response = await request.send();
//
//       // Convert response to a readable format
//       final responseBody = await response.stream.bytesToString();
//       final responseData = jsonDecode(responseBody);
//
//       if (response.statusCode == 200) {
//         print("Success: ${responseData["message"]}");
//         return responseData;
//       } else {
//         throw Exception("Submission failed: ${responseData["message"]}");
//       }
//     } catch (e) {
//       print("Error submitting answers: $e");
//       return {"status": false, "message": "Error submitting answers"};
//     }
//   }
//
//   static Future<Map<String, List<AssessmentQuestion>>>
//       fetchChildrenQuestions() async {
//     try {
//       final headers = await getheader3();
//       final response = await http.get(
//         Uri.parse("${host}/api/list_of_questions"),
//         headers: headers, // Authorization header
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         // Parse API response into model
//         Map<String, List<AssessmentQuestion>> parsedData = {};
//         data['data'].forEach((key, value) {
//           parsedData[key] = List<AssessmentQuestion>.from(
//             value.map((q) => AssessmentQuestion.fromJson(q)),
//           );
//         });
//         return parsedData;
//       } else {
//         throw Exception("Failed to load questions");
//       }
//     } catch (e) {
//       print("Error fetching questions: $e");
//       return {}; // Return empty map in case of error
//     }
//   }
//
//   static Future<String?> makeSOSCallApi(String loc) async {
//     try {
//       Map<String, String> data = {
//         "location": loc,
//       };
//       final url = Uri.parse("${host}/api/sos-call");
//       final headers = await getheader2();
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: data, // Correct encoding for form data
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         print("makeSOSCallApi Status: ${jsonResponse}");
//         return jsonResponse["message"];
//       } else if (response.statusCode == 401) {
//         final jsonResponse = jsonDecode(response.body);
//         print("Unauthorized: ${jsonResponse['error']}");
//         return jsonResponse["error"];
//       } else {
//         print("Request failed with status: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return null;
//     }
//   }
//
//   static Future<BookApointmentModel?> NewApointment(
//       String fname,
//       String pnum,
//       String appointment,
//       String age,
//       String appointment_type,
//       String Date_of_appointment,
//       String location,
//       String page_source,
//       String time_of_appointment,
//       String user_id,
//       Map<String, dynamic> order_data) async {
//     try {
//       final url = Uri.parse("${host}/api/for_new_bookappointments");
//       final headers = await getheader();
//       var request = http.MultipartRequest('POST', url)
//         ..headers.addAll(headers)
//         ..fields['Full_Name'] = fname
//         ..fields['phone_Number'] = pnum
//         ..fields['appointment'] = appointment
//         ..fields['age'] = age
//         ..fields['appointment_type'] = appointment_type
//         ..fields['Date_of_appointment'] = Date_of_appointment
//         ..fields['location'] = location
//         ..fields['page_source'] = page_source
//         ..fields['time_of_appointment'] = time_of_appointment
//         ..fields['payment_json'] = jsonEncode(order_data);
//
//       var response = await request.send();
//       String responseBody = await response.stream.bytesToString();
//       if (response.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(responseBody);
//           print("✅ Appointment Response: $jsonResponse");
//           return BookApointmentModel.fromJson(jsonResponse);
//         } catch (e) {
//           print("⚠️ JSON Parsing Error: $e");
//           return null;
//         }
//       } else {
//         print("❌ Failed to book appointment: ${response.statusCode}");
//         print("Response: $responseBody");
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//     return null;
//   }
//
//   static Future<BookApointmentModel?> ExistApointment(
//       String fname,
//       String pnum,
//       String appointment,
//       String age,
//       String appointment_type,
//       String Date_of_appointment,
//       String location,
//       String page_source,
//       String time_of_appointment,
//       String user_id,
//       String patient_id,
//       Map<String, dynamic> order_data) async {
//     try {
//       final url = Uri.parse("${host}/api/for_exesting_bookappointments");
//       final headers = await getheader();
//       var request = http.MultipartRequest('POST', url)
//         ..headers.addAll(headers)
//         ..fields['Full_Name'] = fname
//         ..fields['phone_Number'] = pnum
//         ..fields['appointment'] = appointment
//         ..fields['age'] = age
//         ..fields['appointment_type'] = appointment_type
//         ..fields['Date_of_appointment'] = Date_of_appointment
//         ..fields['location'] = location
//         ..fields['page_source'] = page_source
//         ..fields['time_of_appointment'] = time_of_appointment
//         ..fields['patient_id'] = patient_id
//         ..fields['payment_json'] = jsonEncode(order_data);
//
//       var response = await request.send();
//       String responseBody = await response.stream.bytesToString();
//       if (response.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(responseBody);
//           print("✅ Existing Appointment Response: $jsonResponse");
//           return BookApointmentModel.fromJson(jsonResponse);
//         } catch (e) {
//           print("⚠️ JSON Parsing Error: $e");
//           return null;
//         }
//       } else {
//         print("❌ Failed to book existing appointment: ${response.statusCode}");
//         print("Response: $responseBody");
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//     return null;
//   }
//
//   static Future<RegisterModel?> PostRegister(String name, String mail,
//       String password, String phone, String fcm_token, String SOSNumber) async {
//     try {
//       Map<String, String> data = {
//         "name": name,
//         "email": mail,
//         "password": password,
//         "phone": phone,
//         "fcm_token": fcm_token,
//         "sos_1": SOSNumber
//       };
//       print(data);
//       final url = Uri.parse("${host}/api/user/userregister");
//       final response = await http.post(
//         url,
//         headers: {
//           HttpHeaders.contentTypeHeader: "application/json",
//         },
//         body: jsonEncode(data),
//       );
//       if (response != null) {
//         final jsonResponse = jsonDecode(response.body);
//         print("PostRegister Status:${response.body}");
//         return RegisterModel.fromJson(jsonResponse);
//       } else {
//         print("Request failed with status: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return null;
//     }
//   }
//
//   static Future<Map<String, dynamic>?> postLogin(
//       String mail, String password, String deviceToken) async {
//     try {
//       Map<String, String> data = {
//         "email": mail,
//         "password": password,
//         "fcm_token": deviceToken,
//       };
//       print("PostLogin: $data");
//       final url = Uri.parse("${host}/api/user/userlogin");
//       print("PostLogin: $url");
//       final response = await http.post(
//         url,
//         headers: {
//           HttpHeaders.contentTypeHeader: "application/json",
//         },
//         body: jsonEncode(data),
//       );
//
//       if (response.statusCode == 200) {
//         // Successful login
//         final jsonResponse = jsonDecode(response.body);
//         print("PostLogin Status: ${response.body}");
//         return {
//           "access_token": jsonResponse["access_token"],
//           "token_type": jsonResponse["token_type"],
//           "expires_in": jsonResponse["expires_in"],
//         };
//       } else if (response.statusCode == 401) {
//         // Unauthorized
//         final jsonResponse = jsonDecode(response.body);
//         print("Unauthorized: ${jsonResponse['error']}");
//         return {
//           "error": jsonResponse["error"],
//           "status": jsonResponse["status"],
//         };
//       } else if (response.statusCode == 403) {
//         final jsonResponse = jsonDecode(response.body);
//         print("Unauthorized: ${jsonResponse['error']}");
//         return {
//           "error": jsonResponse["error"],
//         };
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return null;
//     }
//   }
//
//   static Future<Map<String, dynamic>?> postProfileDetails(String name,
//       String email, String phone, String sos1, String sos2, String sos3) async {
//     try {
//       Map<String, String> data = {
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "sos_1": sos1,
//         "sos_2": sos2,
//         "sos_3": sos3,
//       };
//       print("postProfileDetails: $data");
//
//       final url = Uri.parse("${host}/api/update_user_details1");
//       final headers = await getheader2();
//
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: data,
//       );
//
//       if (response.statusCode == 200) {
//         // Success response
//         final jsonResponse = jsonDecode(response.body);
//         print("postProfileDetails Status: $jsonResponse");
//         return {"message": jsonResponse["message"]}; // Success message
//       } else if (response.statusCode == 401) {
//         // Unauthorized response
//         final jsonResponse = jsonDecode(response.body);
//         print("postProfileDetails Status: $jsonResponse");
//         return {"error": jsonResponse["error"]}; // Unauthorized error message
//       } else if (response.statusCode == 400) {
//         // Handle Bad Request (validation error)
//         final jsonResponse = jsonDecode(response.body);
//         print("postProfileDetails Error: $jsonResponse");
//
//         // Check if errors field exists in the response
//         if (jsonResponse.containsKey("errors")) {
//           return {
//             "error": jsonResponse["errors"]
//           }; // Return validation errors in map
//         } else {
//           return {
//             "error":
//                 "Bad request with status 400, no specific error details available."
//           };
//         }
//       } else {
//         // Handle other non-200, non-400, non-401 status codes
//         print("Request failed with status: ${response.statusCode}");
//         return {"error": "Request failed with status: ${response.statusCode}"};
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return {"error": e.toString()}; // Catch any other errors
//     }
//   }
//
//   static Future<ProfileDetailsModel?> getprofiledetails(String user_id) async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url = Uri.parse("${host}/api/get_user_details");
//         final headers = await getheader1();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getprofiledetails Status:${response.body}");
//           return ProfileDetailsModel.fromJson(jsonResponse);
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<ReviewSubmitModel?> SubmitReviewApi(
//       String appid, String page_source, String rating, String review) async {
//     if (await CheckHeaderValidity()) {
//       try {
//         // Prepare the data
//         Map<String, String> data = {
//           "app_id": appid,
//           "rating": rating,
//           "details": review,
//           "page_source": page_source,
//         };
//         print("SubmitReviewApi: ${data}");
//
//         final url = Uri.parse("$host/api/create_review");
//         final headers =
//             await getheader2(); // Assuming this fetches headers with Authorization
//
//         // Send the POST request
//         final response = await http.post(
//           url,
//           headers: headers,
//           body: data, // Use data directly for x-www-form-urlencoded
//         );
//
//         // Check the response status
//         if (response.statusCode == 200) {
//           final jsonResponse = jsonDecode(response.body);
//           print("SubmitReview Status: ${response.body}");
//           return ReviewSubmitModel.fromJson(jsonResponse);
//           ; // Return as string or adjust as needed
//         } else {
//           print("Error: ${response.statusCode} ${response.body}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<BookingHistoryModel?> getbookinghistory() async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url = Uri.parse("${host}/api/get_user_booking_hisrory");
//         final headers = await getheader();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getbookinghistory Status:${response.body}");
//           return BookingHistoryModel.fromJson(jsonResponse);
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<PreviousBookingModel?> getpreviousbookinghistory() async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url = Uri.parse("${host}/api/get_user_booking_hisrory");
//         final headers = await getheader();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getbookinghistory Status:${response.body}");
//           return PreviousBookingModel.fromJson(jsonResponse);
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<LoginModel?> UpdateRefreshToken() async {
//     try {
//       final url = Uri.parse("${host}/api/refreshToken");
//       final headers = await getheader();
//       final response = await http.post(url, headers: headers);
//       if (response != null) {
//         final jsonResponse = jsonDecode(response.body);
//         print("UpdateRefreshToken response:${response.body}");
//         return LoginModel.fromJson(jsonResponse);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return null;
//     }
//   }
//
//   static Future<ReviewListModel?> getreviewlist(String page_source) async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url = Uri.parse("${host}/api/get_review/${page_source}");
//         final headers = await getheader();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getreviewlist response:${response.body}");
//           return ReviewListModel.fromJson(jsonResponse);
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<LoginModel?> UploadImage(File image) async {
//     try {
//       final url = Uri.parse("${host}/api/update_profile_image");
//       final headers = await getheader1();
//       var request = http.MultipartRequest('POST', url);
//       request.headers['Authorization'] = headers; // Add token if required
//
//       // Attach image file
//       var mimeType = lookupMimeType(image.path);
//       var multipartFile = await http.MultipartFile.fromPath(
//         'user_profile', // Parameter name expected by the API
//         image.path,
//         contentType: mimeType != null ? MediaType.parse(mimeType) : null,
//       );
//       request.files.add(multipartFile);
//
//       // Send request
//       var response = await request.send();
//       if (response != null) {
//         // final jsonResponse = jsonDecode(response.body);
//         // print("UpdateRefreshToken response:${response.body}");
//         // return LoginModel.fromJson(jsonResponse);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return null;
//     }
//   }
//
//   static Future<AddAddressModel?> AddAddressApi(String Flat_no, String street,
//       String area, String landmark, String pincode, int type_of_address) async {
//     if (await CheckHeaderValidity()) {
//       try {
//         // Prepare the data
//         Map<String, dynamic> data = {
//           "Flat_no": Flat_no,
//           "street": street,
//           "area": area,
//           "landmark": landmark,
//           "pincode": pincode,
//           "type_of_address": type_of_address,
//         };
//         print("AddAddressApi Data: ${data}");
//
//         final url = Uri.parse("$host/api/add_user_address");
//         final headers =
//             await getheader(); // Assuming this fetches headers with Authorization
//         // Send the POST request
//         final response = await http.post(
//           url,
//           headers: headers,
//           body: jsonEncode(data), // Use data directly for x-www-form-urlencoded
//         );
//
//         // Check the response status
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("AddAddressApi Response: ${response.body}");
//           return AddAddressModel.fromJson(jsonResponse);
//           ; // Return as string or adjust as needed
//         } else {
//           print("Error: ${response.statusCode} ${response.body}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<AddAddressModel?> EditAddressApi(
//       String Flat_no,
//       String street,
//       String area,
//       String landmark,
//       String pincode,
//       int type_of_address,
//       String address_id) async {
//     if (await CheckHeaderValidity()) {
//       try {
//         // Prepare the data
//         Map<String, dynamic> data = {
//           "Flat_no": Flat_no,
//           "street": street,
//           "area": area,
//           "landmark": landmark,
//           "pincode": pincode,
//           "type_of_address": type_of_address,
//         };
//         print("EditAddressApi Data: ${data}");
//
//         final url = Uri.parse("$host/api/update_user_address/${address_id}");
//         print(url);
//         final headers =
//             await getheader(); // Assuming this fetches headers with Authorization
//         // Send the POST request
//         final response = await http.post(
//           url,
//           headers: headers,
//           body: jsonEncode(data), // Use data directly for x-www-form-urlencoded
//         );
//
//         // Check the response status
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("EditAddressApi Response: ${response.body}");
//           return AddAddressModel.fromJson(jsonResponse);
//           ; // Return as string or adjust as needed
//         } else {
//           print("Error: ${response.statusCode} ${response.body}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<AddressListModel?> getaddresslist() async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url = Uri.parse("${host}/api/get_user_address_details");
//         final headers = await getheader1();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getaddresslist response:${response.body}");
//           return AddressListModel.fromJson(jsonResponse);
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<String?> downloadscriptapi() async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url = Uri.parse("${host}/api/downloadfile/79");
//         final headers = await getheader3();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getaddresslist response:${response.body}");
//           return jsonResponse;
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<PreviousBookingModel?> getpreviousbookings(
//       String pagesource) async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url =
//             Uri.parse("${host}/api/check_previous_bookings/${pagesource}");
//         final headers = await getheader1();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getpreviousbookings response:${response.body}");
//           return PreviousBookingModel.fromJson(jsonResponse);
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<BehaviouralTrackingModel?> getbehaviourallist(
//       String id, String page_source) async {
//     if (await CheckHeaderValidity()) {
//       try {
//         final url =
//             Uri.parse("${host}/api/get_therapy_traking/${id}/${page_source}");
//         print("URL :${url}");
//         final headers = await getheader1();
//         final response = await http.get(url, headers: headers);
//         if (response != null) {
//           final jsonResponse = jsonDecode(response.body);
//           print("getbehaviourallist response:${response.body}");
//           return BehaviouralTrackingModel.fromJson(jsonResponse);
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           return null;
//         }
//       } catch (e) {
//         print("Error occurred: $e");
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }
//
//   static Future<QuoteModel?> getquotes() async {
//     try {
//       final url = Uri.parse("${host}/api/random-quote");
//       print("URL :${url}");
//       final headers = await getheader1();
//       final response = await http.get(url, headers: headers);
//       if (response != null) {
//         final jsonResponse = jsonDecode(response.body);
//         print("getquotes response:${response.body}");
//         return QuoteModel.fromJson(jsonResponse);
//       } else {
//         print("Request failed with status: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return null;
//     }
//   }
//
//   static Future<FeedbackHelathModel?> posthelathFeedback(String msg) async {
//     Map<String, String> data = {"message": msg};
//     try {
//       final url = Uri.parse("${host}/api/feedback-health");
//       print("URL :${url}");
//       final headers = await getheader1();
//       final response = await http.post(url, headers: headers, body: data);
//       if (response != null) {
//         final jsonResponse = jsonDecode(response.body);
//         print("posthelathFeedback response:${response.body}");
//         return FeedbackHelathModel.fromJson(jsonResponse);
//       } else {
//         print("Request failed with status: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return null;
//     }
//   }
// }
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

  static void setupInterceptors(GlobalKey<NavigatorState> navigatorKey) {
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
              case 401:
                print("Unauthorized: Navigating to SignIn");
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Future.microtask(() {
                  navigatorKey.currentState
                      ?.pushNamedAndRemoveUntil('/signin', (route) => false);
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
      final response = await _dio.post("/api/user/userlogin", data: data);
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
      String email, String phone, String sos1, String sos2, String sos3) async {
    try {
      final response = await _dio.post(
        "/api/update_user_details1",
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "sos_1": sos1,
          "sos_2": sos2,
          "sos_3": sos3,
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
      final response = await _dio.get("/api/get_user_details");
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
      final response = await _dio.get("/api/random-quote");
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
        "/api/feedback-health",
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
