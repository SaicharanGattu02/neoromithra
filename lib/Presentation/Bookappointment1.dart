import 'dart:async';
import 'dart:convert' show base64Encode, jsonEncode, utf8;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'AddressListScreen.dart';
import '../Model/AddressListModel.dart';
import 'BookedApointmentsuccessfully.dart';
import 'PaymentStatusScreen.dart';
import 'ShakeWidget.dart';
import 'package:crypto/crypto.dart';

class Bookappointment1 extends StatefulWidget {
  final String pagesource;
  final String patientID;
  final String patient_name;
  final String p_age;
  const Bookappointment1(
      {super.key,
      required this.pagesource,
      required this.patientID,
      required this.patient_name,
      required this.p_age});

  @override
  State<Bookappointment1> createState() => _Bookappointment1State();
}

class _Bookappointment1State extends State<Bookappointment1> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _appointmentController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _appointmentTypeController =
      TextEditingController();
  final TextEditingController _dateOfAppointmentController =
      TextEditingController();
  final TextEditingController _timeOfAppointmentController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _isLoading = false;
  String? appointment;
  String? appointmenttype;
  bool isUpdate = false;
  int address_id = 0;

  // final String environment = "PRODUCTION";
  String environment = "PRODUCTION"; // Change to "SANDBOX" for testing
  String appId = ""; // Merchant ID
  String merchantId = "";
  String saltKey = "";
  int saltIndex = 1;
  final String callbackUrl = "";
  final String apiEndPoint = "/pg/v1/pay";
  String transactionId = "TXN${DateTime.now().millisecondsSinceEpoch}";
  String Orderamount= "";
  String user_id="";

  @override
  void initState() {
    GetAddressList();
    getPhonepeDetailsApi();
    super.initState();
    setState(() {
      _fullNameController.text = widget.patient_name;
      _ageController.text = widget.p_age;
    });
    _fullNameController.addListener(() {
      setState(() {
        _validateFullName = "";
      });
    });
    _phoneNumberController.addListener(() {
      setState(() {
        _validatePhoneNumber = "";
      });
    });

    _appointmentController.addListener(() {
      setState(() {
        _validateAppointment = "";
      });
    });

    _ageController.addListener(() {
      setState(() {
        _validateAge = "";
      });
    });

    _appointmentTypeController.addListener(() {
      setState(() {
        _validateAppointmentType = "";
      });
    });

    _dateOfAppointmentController.addListener(() {
      setState(() {
        _validateDateOfAppointment = "";
      });
    });

    _timeOfAppointmentController.addListener(() {
      setState(() {
        _validateTimeOfAppointment = "";
      });
    });
    _locationController.addListener(() {
      setState(() {
        _validateLocation = "";
      });
    });
  }

  Future<void> initiateTransaction(int amount) async {
    try {
      String user_mobile = await PreferenceService().getString('user_mobile') ?? "";
      setState(() {
        transactionId = "TXN${DateTime.now().millisecondsSinceEpoch}";
        Orderamount = amount.toString();
      });

      Map<String, dynamic> payload = {
        "merchantTransactionId": transactionId,
        "merchantId": merchantId,
        "amount": amount * 100,
        "callbackUrl": callbackUrl,
        "mobileNumber": "${user_mobile}",
        "paymentInstrument": {"type": "PAY_PAGE"}
      };

      log(payload.toString());

      String payloadEncoded = base64Encode(utf8.encode(jsonEncode(payload)));
      var byteCodes = utf8.encode(payloadEncoded + apiEndPoint + saltKey);
      String checksum = "${sha256.convert(byteCodes)}###$saltIndex";

      // Get user_id before calling API
      String user_id = await PreferenceService().getString('user_id') ?? "";

      Map<dynamic, dynamic>? response = await PhonePePaymentSdk.startTransaction(
        payloadEncoded,
        callbackUrl,
        checksum,
        environment,
      );

      if (response != null) {
        log("Payment response: $response");
        String? status = response["status"];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentStatusScreen(
              response: response,
              transactionId: transactionId,
              amount: Orderamount,
              isExistingPatient: widget.patientID.isNotEmpty,
              userId: user_id,
              fullName: _fullNameController.text.trim(),
              phoneNumber: _phoneNumberController.text.trim(),
              appointment: _appointmentController.text.trim(),
              age: _ageController.text.trim(),
              appointmentType: _appointmentTypeController.text.trim(),
              date: _dateOfAppointmentController.text.trim(),
              timeOfAppointment: _timeOfAppointmentController.text.trim(),
              addressId: address_id.toString(),
              pageSource: widget.pagesource,
              patientId: widget.patientID,
              onSuccess: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ApointmentSuccess()),
                );
              },
            ),
          ),
        );
      } else {
        log("⚠️ Payment response is null");
      }
    } catch (e) {
      log("🚨 Error: $e");
    }
  }


  List<Address> addresses = [];
  Future<void> GetAddressList() async {
    user_id = await PreferenceService().getString('user_id') ?? "";
    final response = await Userapi.getAddressList();
    setState(() {
      if (response?.status == true) {
        addresses = response?.address ?? [];
        print(addresses);
      } else {}
    });
  }

  Future<void>getPhonepeDetailsApi() async {
    final response = await Userapi.getPhonepeDetails();
    setState(() {
      if (response?.status == true) {
        environment = response?.data?[0].env??"";
        appId = response?.data?[0].appId??"";
        merchantId = response?.data?[0].merchantId??"";
        saltKey = response?.data?[0].saltKey??"";
        saltIndex = response?.data?[0].saltIndex??0;
        PhonePePaymentSdk.init(environment, appId, merchantId, true);
      }
    });
  }

  int? selectedAddressIndex;

  Future<void> NewBookAppointment() async {
    String user_id = await PreferenceService().getString('user_id') ?? "";
    String fullname = _fullNameController.text.trim();
    String phone = _phoneNumberController.text.trim();
    String appointment = _appointmentController.text.trim();
    String age = _ageController.text.trim();
    String appointmentType = _appointmentTypeController.text.trim();
    String date = _dateOfAppointmentController.text.trim();
    String timeOfAppointment = _timeOfAppointmentController.text.trim();
    // Map<String,dynamic> order_data = {
    //   "amount":"${Orderamount}",
    //   "transactionID":"$transactionId"
    // };
    Map<String,dynamic> order_data = {
      "amount":"1",
      "transactionID":"XYZKJUHGKIJNKLJNOIJ"
    };
    final data = await Userapi.newApointment(
        fullname,
        phone,
        appointment,
        age,
        appointmentType,
        date,
        address_id.toString(),
        widget.pagesource,
        timeOfAppointment,
        user_id,
        order_data);
    if (data != null) {
      setState(() {
        if (data.status == true) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ApointmentSuccess()));
        }
      });
    } else {
      print("Data not fetched.");
    }
  }

  Future<void> ExistBookAppointment() async {
    String user_id = await PreferenceService().getString('user_id') ?? "";
    String fullname = _fullNameController.text.trim();
    String phone = _phoneNumberController.text.trim();
    String appointment = _appointmentController.text.trim();
    String age = _ageController.text.trim();
    String appointmentType = _appointmentTypeController.text.trim();
    String date = _dateOfAppointmentController.text.trim();
    String timeOfAppointment = _timeOfAppointmentController.text.trim();
    // Map<String,dynamic> order_data = {
    //   "amount":"${Orderamount}",
    //   "transactionID":"$transactionId"
    // };
    Map<String,dynamic> order_data = {
      "amount":"1",
      "transactionID":"XYZKJUHGKIJNKLJNOIJ"
    };
    final data = await Userapi.existApointment(
        fullname,
        phone,
        appointment,
        age,
        appointmentType,
        date,
        address_id.toString(),
        widget.pagesource,
        timeOfAppointment,
        user_id,
        widget.patientID.toString(),
        order_data
    );
    if (data != null) {
      setState(() {
        if (data.status == true) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ApointmentSuccess()));
        }
      });
    } else {
      print("Data not fetched.");
    }
  }

  String _validateFullName = "";
  String _validatePhoneNumber = "";
  String _validateAppointment = "";
  String _validateAge = "";
  String _validateAppointmentType = "";
  String _validateDateOfAppointment = "";
  String _validateTimeOfAppointment = "";
  String _validateLocation = "";

  void _validateFields() {
    setState(() {
      _validateFullName =
          _fullNameController.text.isEmpty ? "Please enter your full name" : "";
      _validatePhoneNumber = _phoneNumberController.text.isEmpty ||
              _phoneNumberController.text.length < 10
          ? "Please enter your phone number"
          : "";
      _validateAppointment = _appointmentController.text.isEmpty
          ? "Please select your appointment"
          : "";
      _validateAge = _ageController.text.isEmpty ? "Please enter your age" : "";
      _validateAppointmentType = _appointmentTypeController.text.isEmpty
          ? "Please enter appointment type"
          : "";
      _validateDateOfAppointment = _dateOfAppointmentController.text.isEmpty
          ? "Please enter the date of appointment"
          : "";
      _validateTimeOfAppointment = _timeOfAppointmentController.text.isEmpty
          ? "Please enter the time of appointment"
          : "";
      _validateLocation = address_id == 0 ? "Please select your location" : "";

      _isLoading = _validateFullName.isEmpty &&
          _validatePhoneNumber.isEmpty &&
          _validateAppointment.isEmpty &&
          _validateAge.isEmpty &&
          _validateAppointmentType.isEmpty &&
          _validateDateOfAppointment.isEmpty &&
          _validateTimeOfAppointment.isEmpty &&
          _validateLocation.isEmpty;

      if (_isLoading) {
        initiateTransaction(800);
        // if (widget.patientID != "") {
        //   ExistBookAppointment();
        // } else {
        //   NewBookAppointment();
        // }
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PaymentStatusScreen(
        //       response: {},
        //       transactionId: transactionId,
        //       amount: Orderamount,
        //       isExistingPatient: widget.patientID.isNotEmpty,
        //       userId: user_id,
        //       fullName: _fullNameController.text.trim(),
        //       phoneNumber: _phoneNumberController.text.trim(),
        //       appointment: _appointmentController.text.trim(),
        //       age: _ageController.text.trim(),
        //       appointmentType: _appointmentTypeController.text.trim(),
        //       date: _dateOfAppointmentController.text.trim(),
        //       timeOfAppointment: _timeOfAppointmentController.text.trim(),
        //       addressId: address_id.toString(),
        //       pageSource: widget.pagesource,
        //       patientId: widget.patientID,
        //       onSuccess: () {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(builder: (context) => ApointmentSuccess()),
        //         );
        //       },
        //     ),
        //   ),
        // );
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfAppointmentController.text =
            DateFormat('yyyy/MM/dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      // Parse the selected date from the date controller
      final selectedDate =
          DateFormat('yyyy/MM/dd').parse(_dateOfAppointmentController.text);

      // Create DateTime objects for today and the selected time
      final selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Check if the selected date is today
      if (selectedDate
          .isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
        // If the selected time is before the current time today, show an error
        if (selectedDateTime.isBefore(now)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selected time cannot be in the past.'),
            ),
          );
          setState(() {
            _timeOfAppointmentController.text = "";
          });
          return;
        }
      }

      // Update the time field if everything is valid
      setState(() {
        _timeOfAppointmentController.text =
            DateFormat('HH:mm').format(selectedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Appointment",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: Color(0xff3EA4D2),
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: Color(0xff3EA4D2)), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _buildTextField("Full Name", _fullNameController, _validateFullName,
                TextInputType.name, r'^[a-zA-Z\s]+$'),
            _buildTextField("Phone Number", _phoneNumberController,
                _validatePhoneNumber, TextInputType.number, r'^\d{0,10}$'),
            _buildDropdownField(
                "Appointment",
                appointment,
                _appointmentController,
                _validateAppointment,
                ['Self', 'Children']),
            _buildTextField("Age", _ageController, _validateAge,
                TextInputType.number, r'^\d{0,3}$'),
            // _buildTextField("Appointment Mode", _appointmentTypeController, _validateAppointmentType, TextInputType.text),
            Text(
              "Appointment Mode",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              value: appointmenttype,
              onChanged: (value) {
                setState(() {
                  appointmenttype = value;
                  if (appointmenttype == "Online") {
                    _appointmentTypeController.text = "0";
                  } else {
                    _appointmentTypeController.text = "1";
                  }
                  _validateAppointmentType = "";
                });
              },
              items: [
                'Online',
                'Offline',
              ].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      letterSpacing: 0,
                      height: 1.2,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffffffff),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
                ),
              ),
              hint: Align(
                alignment: Alignment.center,
                child: Text(
                  "Select appointment type",
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0,
                    color: Color(0xffAFAFAF),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            if (_validateAppointmentType.isNotEmpty) ...[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                width: screenWidth * 0.6,
                child: ShakeWidget(
                  key: Key("value"),
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    _validateAppointmentType,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ] else ...[
              const SizedBox(
                height: 15,
              ),
            ],

            _buildDateField("Date Of Appointment", _dateOfAppointmentController,
                _validateDateOfAppointment, context),
            _buildTimeField("Time Of Appointment", _timeOfAppointmentController,
                _validateTimeOfAppointment, context),

            Column(
              children: List.generate(addresses.length, (index) {
                String title = addresses[index].typeOfAddress == 1
                    ? "Current Address"
                    : "Permanent Address";
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedAddressIndex == index,
                        onChanged: (bool? value) {
                          setState(() {
                            // Update the selected index
                            selectedAddressIndex = value == true ? index : null;
                            address_id = addresses[index].id ?? 0;
                            print("Address id:${address_id}");
                            _validateLocation = "";
                          });
                        },
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(title),
                          subtitle: Text(
                              "${addresses[index].flatNo}, ${addresses[index].street}, ${addresses[index].area} - ${addresses[index].landmark}, ${addresses[index].pincode}"),
                          contentPadding: EdgeInsets
                              .zero, // Remove padding for better alignment
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            if (_validateLocation.isNotEmpty) ...[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                width: MediaQuery.of(context).size.width * 0.6,
                child: ShakeWidget(
                  key: Key("value"),
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    _validateLocation,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(height: 15),
            ],
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (addresses.isNotEmpty) {
                      // if (!_isLoading) {
                        _validateFields();
                      // }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressListScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please first add address.",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Inter"),
                          ),
                          duration: Duration(seconds: 1),
                          backgroundColor: Color(0xFF32657B),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3EA4D2), // Updated button color
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5, // Adds a slight shadow for better UI
                  ),
                  child:
                  // _isLoading
                  //     ? SizedBox(
                  //         width: 24,
                  //         height: 24,
                  //         child: CircularProgressIndicator(
                  //           color: Colors.white,
                  //           strokeWidth: 3,
                  //         ),
                  //       )
                  //     :
                  Text(
                          "Book Appointment",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Epi',
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String validation, TextInputType keyboardType,
      [String? pattern]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: keyboardType,
          inputFormatters: pattern != null
              ? [FilteringTextInputFormatter.allow(RegExp(pattern))]
              : [],
          decoration: InputDecoration(
            hintText: "Enter your $label",
            hintStyle: TextStyle(
              fontSize: 15,
              letterSpacing: 0,
              height: 1.2,
              color: Color(0xffAFAFAF),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
          ),
        ),
        if (validation.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ShakeWidget(
              key: Key("value"),
              duration: Duration(milliseconds: 700),
              child: Text(
                validation,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 15),
        ]
      ],
    );
  }

  Widget _buildDropdownField(
      String label,
      String? value,
      TextEditingController controller,
      String validation,
      List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
          ),
          hint: Align(
            alignment: Alignment.center,
            child: Text(
              "Select appointment",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 0,
                color: Color(0xffAFAFAF),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              controller.text = newValue!;
              appointment = newValue;
            });
          },
          onSaved: (String? newValue) {
            controller.text = newValue!;
            appointment = newValue;
          },
        ),
        if (validation.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ShakeWidget(
              key: Key("value"),
              duration: Duration(milliseconds: 700),
              child: Text(
                validation,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 15),
        ]
      ],
    );
  }

  Widget _buildDateField(String label, TextEditingController controller,
      String validation, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            hintText: "Select your $label",
            hintStyle: TextStyle(
              fontSize: 15,
              letterSpacing: 0,
              height: 1.2,
              color: Color(0xffAFAFAF),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
          ),
        ),
        if (validation.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.8,
            child: ShakeWidget(
              key: Key("value"),
              duration: Duration(milliseconds: 700),
              child: Text(
                validation,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 15),
        ]
      ],
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller,
      String validation, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          readOnly: true,
          onTap: () => _selectTime(context),
          decoration: InputDecoration(
            hintText: "Select your $label",
            hintStyle: TextStyle(
              fontSize: 15,
              letterSpacing: 0,
              height: 1.2,
              color: Color(0xffAFAFAF),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
          ),
        ),
        if (validation.isNotEmpty) ...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ShakeWidget(
              key: Key("value"),
              duration: Duration(milliseconds: 700),
              child: Text(
                validation,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 15),
        ]
      ],
    );
  }
}
