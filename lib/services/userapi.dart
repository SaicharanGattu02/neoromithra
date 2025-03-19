import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:neuromithra/Model/QuoteModel.dart';
import '../Model/AddAddressModel.dart';
import '../Model/AddressListModel.dart';
import '../Model/AssessmentQuestion.dart';
import '../Model/BehaviouralTrackingModel.dart';
import '../Model/BookApointmentModel.dart';
import '../Model/BookingHistoryModel.dart';
import '../Model/FeedbackHelathModel.dart';
import '../Model/LoginModel.dart';
import '../Model/PreviousBookingModel.dart';
import '../Model/ProfileDetailsModel.dart';
import '../Model/RegisterModel.dart';
import '../Model/ReviewListModel.dart';
import '../Model/ReviewSubmitModel.dart';
import 'other_services.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class Userapi {
  // static String host = "https://admin.neuromitra.com";
  static String host = "http://192.168.0.61:8080";

  static Future<Map<String, List<AssessmentQuestion>>> fetchQuestions() async {
    try {
      final headers = await getheader3();
      final response = await http.get(
        Uri.parse("${host}/api/list_of_questions"),
        headers: headers, // Authorization header
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Parse API response into model
        Map<String, List<AssessmentQuestion>> parsedData = {};
        data['data'].forEach((key, value) {
          parsedData[key] = List<AssessmentQuestion>.from(
            value.map((q) => AssessmentQuestion.fromJson(q)),
          );
        });
        return parsedData;
      } else {
        throw Exception("Failed to load questions");
      }
    } catch (e) {
      print("Error fetching questions: $e");
      return {}; // Return empty map in case of error
    }
  }

  static Future<String?> makeSOSCallApi(String loc) async {
    try {
      Map<String, String> data = {
        "location": loc,
      };
      final url = Uri.parse("${host}/api/sos-call");
      final headers = await getheader2();
      final response = await http.post(
        url,
        headers: headers,
        body: data, // Correct encoding for form data
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("makeSOSCallApi Status: ${jsonResponse}");
        return jsonResponse["message"];
      } else if (response.statusCode == 401) {
        final jsonResponse = jsonDecode(response.body);
        print("Unauthorized: ${jsonResponse['error']}");
        return jsonResponse["error"];
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<BookApointmentModel?> NewApointment(
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
          'time_of_appointment': time_of_appointment,
          'location': location,
          'page_source': page_source
        });
        print("Apointment data: $body");

        final url = Uri.parse("${host}/api/for_new_bookappointments");
        final headers = await getheader();
        final response = await http.post(url, headers: headers, body: body);
        final jsonResponse = jsonDecode(response.body);
        print("Apointment Status:${response.body}");
        return BookApointmentModel.fromJson(jsonResponse);
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<BookApointmentModel?> ExistApointment(
      String fname,
      String pnum,
      String appointment,
      String age,
      String appointment_type,
      String Date_of_appointment,
      String location,
      String page_source,
      String time_of_appointment,
      String user_id,
      String patient_id) async {
    if (await CheckHeaderValidity()) {
      try {
        final body = jsonEncode({
          'Full_Name': fname,
          'phone_Number': pnum,
          'appointment': appointment,
          'age': age,
          'appointment_type': appointment_type,
          'Date_of_appointment': Date_of_appointment,
          'time_of_appointment': time_of_appointment,
          'location': location,
          'page_source': page_source,
          'patient_id': patient_id
        });
        print("Apointment data: $body");
        final url = Uri.parse("${host}/api/for_exesting_bookappointments");
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
    } else {
      return null;
    }
  }

  static Future<RegisterModel?> PostRegister(String name, String mail,
      String password, String phone, String fcm_token, String SOSNumber) async {
    try {
      Map<String, String> data = {
        "name": name,
        "email": mail,
        "password": password,
        "phone": phone,
        "fcm_token": fcm_token,
        "sos_1": SOSNumber
      };
      print(data);
      final url = Uri.parse("${host}/api/user/userregister");
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

  static Future<Map<String, dynamic>?> postLogin(
      String mail, String password, String deviceToken) async {
    try {
      Map<String, String> data = {
        "email": mail,
        "password": password,
        "fcm_token": deviceToken,
      };
      print("PostLogin: $data");
      final url = Uri.parse("${host}/api/user/userlogin");
      print("PostLogin: $url");
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successful login
        final jsonResponse = jsonDecode(response.body);
        print("PostLogin Status: ${response.body}");
        return {
          "access_token": jsonResponse["access_token"],
          "token_type": jsonResponse["token_type"],
          "expires_in": jsonResponse["expires_in"],
        };
      } else if (response.statusCode == 401) {
        // Unauthorized
        final jsonResponse = jsonDecode(response.body);
        print("Unauthorized: ${jsonResponse['error']}");
        return {
          "error": jsonResponse["error"],
          "status": jsonResponse["status"],
        };
      } else if (response.statusCode == 403) {
        final jsonResponse = jsonDecode(response.body);
        print("Unauthorized: ${jsonResponse['error']}");
        return {
          "error": jsonResponse["error"],
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
      Map<String, String> data = {
        "name": name,
        "email": email,
        "phone": phone,
        "sos_1": sos1,
        "sos_2": sos2,
        "sos_3": sos3,
      };
      print("postProfileDetails: $data");

      final url = Uri.parse("${host}/api/update_user_details1");
      final headers = await getheader2();

      final response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        // Success response
        final jsonResponse = jsonDecode(response.body);
        print("postProfileDetails Status: $jsonResponse");
        return {"message": jsonResponse["message"]}; // Success message
      } else if (response.statusCode == 401) {
        // Unauthorized response
        final jsonResponse = jsonDecode(response.body);
        print("postProfileDetails Status: $jsonResponse");
        return {"error": jsonResponse["error"]}; // Unauthorized error message
      } else if (response.statusCode == 400) {
        // Handle Bad Request (validation error)
        final jsonResponse = jsonDecode(response.body);
        print("postProfileDetails Error: $jsonResponse");

        // Check if errors field exists in the response
        if (jsonResponse.containsKey("errors")) {
          return {
            "error": jsonResponse["errors"]
          }; // Return validation errors in map
        } else {
          return {
            "error":
                "Bad request with status 400, no specific error details available."
          };
        }
      } else {
        // Handle other non-200, non-400, non-401 status codes
        print("Request failed with status: ${response.statusCode}");
        return {"error": "Request failed with status: ${response.statusCode}"};
      }
    } catch (e) {
      print("Error occurred: $e");
      return {"error": e.toString()}; // Catch any other errors
    }
  }

  static Future<ProfileDetailsModel?> getprofiledetails(String user_id) async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/get_user_details");
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
    } else {
      return null;
    }
  }

  static Future<ReviewSubmitModel?> SubmitReviewApi(
      String appid, String page_source, String rating, String review) async {
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
        final headers =
            await getheader2(); // Assuming this fetches headers with Authorization

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
          return ReviewSubmitModel.fromJson(jsonResponse);
          ; // Return as string or adjust as needed
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

  static Future<PreviousBookingModel?> getpreviousbookinghistory() async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/get_user_booking_hisrory");
        final headers = await getheader();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getbookinghistory Status:${response.body}");
          return PreviousBookingModel.fromJson(jsonResponse);
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
      final response = await http.post(url, headers: headers);
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

  static Future<ReviewListModel?> getreviewlist(String page_source) async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/get_review/${page_source}");
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

  static Future<LoginModel?> UploadImage(File image) async {
    try {
      final url = Uri.parse("${host}/api/update_profile_image");
      final headers = await getheader1();
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = headers; // Add token if required

      // Attach image file
      var mimeType = lookupMimeType(image.path);
      var multipartFile = await http.MultipartFile.fromPath(
        'user_profile', // Parameter name expected by the API
        image.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );
      request.files.add(multipartFile);

      // Send request
      var response = await request.send();
      if (response != null) {
        // final jsonResponse = jsonDecode(response.body);
        // print("UpdateRefreshToken response:${response.body}");
        // return LoginModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<AddAddressModel?> AddAddressApi(String Flat_no, String street,
      String area, String landmark, String pincode, int type_of_address) async {
    if (await CheckHeaderValidity()) {
      try {
        // Prepare the data
        Map<String, dynamic> data = {
          "Flat_no": Flat_no,
          "street": street,
          "area": area,
          "landmark": landmark,
          "pincode": pincode,
          "type_of_address": type_of_address,
        };
        print("AddAddressApi Data: ${data}");

        final url = Uri.parse("$host/api/add_user_address");
        final headers =
            await getheader(); // Assuming this fetches headers with Authorization
        // Send the POST request
        final response = await http.post(
          url,
          headers: headers,
          body: jsonEncode(data), // Use data directly for x-www-form-urlencoded
        );

        // Check the response status
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("AddAddressApi Response: ${response.body}");
          return AddAddressModel.fromJson(jsonResponse);
          ; // Return as string or adjust as needed
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

  static Future<AddAddressModel?> EditAddressApi(
      String Flat_no,
      String street,
      String area,
      String landmark,
      String pincode,
      int type_of_address,
      String address_id) async {
    if (await CheckHeaderValidity()) {
      try {
        // Prepare the data
        Map<String, dynamic> data = {
          "Flat_no": Flat_no,
          "street": street,
          "area": area,
          "landmark": landmark,
          "pincode": pincode,
          "type_of_address": type_of_address,
        };
        print("EditAddressApi Data: ${data}");

        final url = Uri.parse("$host/api/update_user_address/${address_id}");
        print(url);
        final headers =
            await getheader(); // Assuming this fetches headers with Authorization
        // Send the POST request
        final response = await http.post(
          url,
          headers: headers,
          body: jsonEncode(data), // Use data directly for x-www-form-urlencoded
        );

        // Check the response status
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("EditAddressApi Response: ${response.body}");
          return AddAddressModel.fromJson(jsonResponse);
          ; // Return as string or adjust as needed
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

  static Future<AddressListModel?> getaddresslist() async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/get_user_address_details");
        final headers = await getheader1();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getaddresslist response:${response.body}");
          return AddressListModel.fromJson(jsonResponse);
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

  static Future<String?> downloadscriptapi() async {
    if (await CheckHeaderValidity()) {
      try {
        final url = Uri.parse("${host}/api/downloadfile/79");
        final headers = await getheader3();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getaddresslist response:${response.body}");
          return jsonResponse;
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

  static Future<PreviousBookingModel?> getpreviousbookings(
      String pagesource) async {
    if (await CheckHeaderValidity()) {
      try {
        final url =
            Uri.parse("${host}/api/check_previous_bookings/${pagesource}");
        final headers = await getheader1();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getpreviousbookings response:${response.body}");
          return PreviousBookingModel.fromJson(jsonResponse);
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

  static Future<BehaviouralTrackingModel?> getbehaviourallist(
      String id, String page_source) async {
    if (await CheckHeaderValidity()) {
      try {
        final url =
            Uri.parse("${host}/api/get_therapy_traking/${id}/${page_source}");
        print("URL :${url}");
        final headers = await getheader1();
        final response = await http.get(url, headers: headers);
        if (response != null) {
          final jsonResponse = jsonDecode(response.body);
          print("getbehaviourallist response:${response.body}");
          return BehaviouralTrackingModel.fromJson(jsonResponse);
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

  static Future<QuoteModel?> getquotes() async {
    try {
      final url = Uri.parse("${host}/api/random-quote");
      print("URL :${url}");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("getquotes response:${response.body}");
        return QuoteModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<FeedbackHelathModel?> posthelathFeedback(String msg) async {
    Map<String, String> data = {"message": msg};
    try {
      final url = Uri.parse("${host}/api/feedback-health");
      print("URL :${url}");
      final headers = await getheader1();
      final response = await http.post(url, headers: headers, body: data);
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("posthelathFeedback response:${response.body}");
        return FeedbackHelathModel.fromJson(jsonResponse);
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
