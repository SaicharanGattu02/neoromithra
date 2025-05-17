import 'dart:async';
import 'dart:convert' show base64Encode, jsonEncode, utf8;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neuromithra/Providers/AddressListProviders.dart';
import 'package:neuromithra/Providers/UserProvider.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:provider/provider.dart';
import '../Model/ChildListModel.dart';
import '../Model/PhonepeDetails.dart';
import '../Model/SuccessModel.dart';
import '../Providers/BookingHistoryProviders.dart';
import '../Providers/ChildProvider.dart';
import '../utils/Color_Constants.dart';
import '../utils/constants.dart';
import 'ShakeWidget.dart';
import 'package:crypto/crypto.dart';

class Bookappointment1 extends StatefulWidget {
  final String serviceID;
  final String price;
  final String appointmentMode;
  const Bookappointment1(
      {super.key,
      required this.serviceID,
      required this.appointmentMode,
      required this.price});

  @override
  State<Bookappointment1> createState() => _Bookappointment1State();
}

class _Bookappointment1State extends State<Bookappointment1> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _dateOfAppointmentController =
      TextEditingController();

  int address_id = 0;
  String patient_id = "";

  // final String environment = "PRODUCTION";
  String environment = "SANDBOX";
  String appId = "PGTESTPAYUAT77";
  String merchantId = "PGTESTPAYUAT77";
  String saltKey = "14fa5465-f8a7-443f-8477-f986b8fcfde9";
  int saltIndex = 1;
  final String callbackUrl = "";
  final String apiEndPoint = "/pg/v1/pay";
  String transactionId = "TXN${DateTime.now().millisecondsSinceEpoch}";
  String Orderamount = "";
  String user_id = "";

  String _selected_appointment_type = 'self';
  String _selected_appointment_mode = 'online';
  String selectedGender = 'Male';
  int total_amount = 0;
  List<PhonepeKeys> _phonepeKeys = [];

  @override
  void initState() {
    super.initState();
    _selected_appointment_mode =
        widget.appointmentMode == 'both' ? 'online' : widget.appointmentMode;
    Provider.of<AddressListProvider>(context, listen: false).getAddressList();
    final provider =
        Provider.of<BookingHistoryProvider>(context, listen: false);
    PhonePePaymentSdk.init(environment, appId, merchantId, true);
    // provider.getPhonepeDetails().then((_) {
    //   setState(() {
    //     _phonepeKeys = provider.phonpekeys;
    //     merchantId=_phonepeKeys[0].merchantId??"";
    //     appId=_phonepeKeys[0].appId??"";
    //     saltIndex=_phonepeKeys[0].saltIndex??0;
    //     saltKey=_phonepeKeys[0].saltKey??"";
    //   });
    // });
    var res = Provider.of<UserProviders>(context, listen: false).userData;
    setState(() {
      _fullNameController.text = res.name ?? "";
      _phoneNumberController.text = res.contact.toString() ?? '';
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
    _ageController.addListener(() {
      setState(() {
        _validateAge = "";
      });
    });
    _daysController.addListener(() {
      setState(() {
        _validateDays = "";
      });
    });
    _dateOfAppointmentController.addListener(() {
      setState(() {
        _validateDateOfAppointment = "";
      });
    });
  }

  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final Set<String> _selectedDays = {};

  void _onDayTapped(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        if (_selectedDays.length < 5) {
          _selectedDays.add(day);
        } else {
          showAnimatedTopSnackBar(context, 'You can select only 5 days');
        }
      }
    });
  }

  Future<void> initiateTransaction(int amount) async {
    try {
      String user_mobile =
          await PreferenceService().getString('user_mobile') ?? "";
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
      Map<dynamic, dynamic>? response =
          await PhonePePaymentSdk.startTransaction(
        payloadEncoded,
        callbackUrl,
        checksum,
        environment,
      );

      if (response != null) {
        log("Payment response: $response");
        String? status = response["status"];
        if (status == "SUCCESS") {
          Map<String, dynamic> data = {
            "appointment_for": _selected_appointment_type,
            "age": _ageController.text,
            "gender": selectedGender,
            "appointment_mode": _selected_appointment_mode,
            "appointment_request_date": _dateOfAppointmentController.text,
            "service_id": widget.serviceID,
            "days": _daysController.text,
            "amount": total_amount,
            "address": address_id,
            "calender_days": _selectedDays.toList(),
            "patient_id": patient_id,
          };
          final response =
              await Provider.of<BookingHistoryProvider>(context, listen: false)
                  .bookAppointment(data);
          if (response?.status == true) {
            context.pushReplacement("/appointment_success");
          } else {
            debugPrint("Data not fetched.");
          }
        }
      } else {
        log("⚠️ Payment response is null");
      }
    } catch (e) {
      log("🚨 Error: $e");
    }
  }

  int? selectedAddressIndex;

  String _validateFullName = "";
  String _validatePhoneNumber = "";
  String _validateAge = "";
  String _validateDays = "";
  String _validateDateOfAppointment = "";
  String _validateLocation = "";
  String _validateWeekDays = "";

  void _validateFields() {
    setState(() {
      _validateAge = _ageController.text.isEmpty ? "Please Enter your Age" : "";
      _validateDays =
          _daysController.text.isEmpty ? "Please Enter Number of Days" : "";

      _validateDateOfAppointment = _dateOfAppointmentController.text.isEmpty
          ? "Please Enter The Date Of Appointment"
          : "";

      _validateLocation = address_id == 0 ? "Please Select Your Location" : "";
      _validateWeekDays =
          _selectedDays.length <= 4 ? "Please Select Week Days" : "";

      if (_validateAge.isEmpty &&
          _validateDateOfAppointment.isEmpty &&
          _validateWeekDays.isEmpty &&
          _validateLocation.isEmpty) {
        // bookAppointment();
        initiateTransaction(1);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primarycolor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primarycolor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfAppointmentController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (pickedTime != null) {
  //     final now = DateTime.now();
  //     // Parse the selected date from the date controller
  //     final selectedDate =
  //         DateFormat('yyyy-MM-dd').parse(_dateOfAppointmentController.text);
  //     // Create DateTime objects for today and the selected time
  //     final selectedDateTime = DateTime(
  //       selectedDate.year,
  //       selectedDate.month,
  //       selectedDate.day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //
  //     // Check if the selected date is today
  //     if (selectedDate
  //         .isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
  //       // If the selected time is before the current time today, show an error
  //       if (selectedDateTime.isBefore(now)) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Selected time cannot be in the past.'),
  //           ),
  //         );
  //         setState(() {
  //           _timeOfAppointmentController.text = "";
  //         });
  //         return;
  //       }
  //     }
  //
  //     // Update the time field if everything is valid
  //     setState(() {
  //       _timeOfAppointmentController.text =
  //           DateFormat('HH:mm').format(selectedDateTime);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Appointment",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "general_sans",
                color: primarycolor,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildDropdownField(
            //     "Appointment",
            //     appointment,
            //     _appointmentController,
            //     _validateAppointment,
            //     ['Self', 'Children']),
            Text(
              "Appointment Type",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "general_sans"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selected_appointment_type = 'self';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _selected_appointment_type == 'self'
                            ? primarycolor
                            : Colors.grey.shade300,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36)),
                      foregroundColor: _selected_appointment_type == 'self'
                          ? primarycolor
                          : Colors.grey,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      textStyle: TextStyle(
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      'Self',
                      style: TextStyle(
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: 100,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selected_appointment_type = 'child';
                      });
                      _showChildListBottomSheet(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _selected_appointment_type == 'child'
                            ? primarycolor
                            : Colors.grey.shade300,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36)),
                      foregroundColor: _selected_appointment_type == 'child'
                          ? primarycolor
                          : Colors.grey,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      textStyle: TextStyle(
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      'Children',
                      style: TextStyle(
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_selected_appointment_type != 'self') ...[
              Consumer<ChildProvider>(
                builder: (context, provider, child) {
                  final child = (provider.childDetails.length != 0)
                      ? provider.childDetails[0]
                      : null;
                  patient_id = child?.id.toString() ?? "";
                  _ageController.text = child?.age.toString() ?? "";
                  selectedGender = child?.gender?.toLowerCase()??"";
                  return ((child?.name ?? "").isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Patient Details',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'general_sans',
                                color: Colors.black,
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.transparent),
                              ),
                              elevation: 2,
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name: ${child?.name ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'general_sans',
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Gender: ${child?.gender ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'general_sans',
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Age: ${child?.age ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'general_sans',
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          _showChildListBottomSheet(context);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: primarycolor,
                                            width: 1,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          foregroundColor: primarycolor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 0),
                                          textStyle: TextStyle(
                                            fontFamily: "general_sans",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        child: Text(
                                          'Change',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "general_sans",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink();
                },
              ),
            ],
            if (_selected_appointment_type == 'self') ...[
              _buildTextField(
                  "Full Name",
                  _fullNameController,
                  _validateFullName,
                  TextInputType.name,
                  r'^[a-zA-Z\s]+$',
                  true),
              _buildTextField(
                  "Phone Number",
                  _phoneNumberController,
                  _validatePhoneNumber,
                  TextInputType.number,
                  r'^\d{0,10}$',
                  true),
              _buildTextField("Age", _ageController, _validateAge,
                  TextInputType.number, r'^\d{0,9}$'),
              Text(
                "Gender",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: "general_sans"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedGender = 'Male';
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: selectedGender == 'Male'
                              ? primarycolor
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36)),
                        foregroundColor: selectedGender == 'Male'
                            ? primarycolor
                            : Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        textStyle: TextStyle(
                          fontFamily: "general_sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      child: Text(
                        'Male',
                        style: TextStyle(
                          fontFamily: "general_sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 100,
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedGender = 'Female';
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: selectedGender == 'Female'
                              ? primarycolor
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36)),
                        foregroundColor: selectedGender == 'Female'
                            ? primarycolor
                            : Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        textStyle: TextStyle(
                          fontFamily: "general_sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      child: Text(
                        'Female',
                        style: TextStyle(
                          fontFamily: "general_sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.appointmentMode == 'both' ||
                    widget.appointmentMode == 'online')
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      width: 100,
                      height: 45,
                      child: OutlinedButton(
                        onPressed: widget.appointmentMode == 'both'
                            ? () {
                                setState(() {
                                  _selected_appointment_mode = 'online';
                                });
                              }
                            : null, // disable button if only one mode
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _selected_appointment_mode == 'online'
                                ? primarycolor
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                          foregroundColor:
                              _selected_appointment_mode == 'online'
                                  ? primarycolor
                                  : Colors.grey,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          textStyle: TextStyle(
                            fontFamily: "general_sans",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        child: Text('Online'),
                      ),
                    ),
                  ),
                if (widget.appointmentMode == 'both' ||
                    widget.appointmentMode == 'offline')
                  SizedBox(
                    width: 100,
                    height: 45,
                    child: OutlinedButton(
                      onPressed: widget.appointmentMode == 'both'
                          ? () {
                              setState(() {
                                _selected_appointment_mode = 'offline';
                              });
                            }
                          : null,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: _selected_appointment_mode == 'offline'
                              ? primarycolor
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        foregroundColor: _selected_appointment_mode == 'offline'
                            ? primarycolor
                            : Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        textStyle: TextStyle(
                          fontFamily: "general_sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      child: Text('Offline'),
                    ),
                  ),
              ],
            ),
            _buildDateField("Date Of Appointment", _dateOfAppointmentController,
                _validateDateOfAppointment, context),
            _buildTextField(
              "Days",
              _daysController,
              _validateDays,
              TextInputType.number,
              r'^\d{0,9}$',
              false,
              (value) {
                final days = int.tryParse(value) ?? 1;
                Provider.of<BookingHistoryProvider>(context, listen: false)
                    .updatePriceByDays(days,
                        ratePerDay: int.parse(widget.price));
              },
            ),

            Consumer<BookingHistoryProvider>(
              builder: (context, provider, child) {
                total_amount = provider.price;
                return Text(
                  "Total Price For Service : ₹${provider.price}",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "general_sans",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              },
            ),

            // _buildTimeField("Time Of Appointment", _timeOfAppointmentController,
            //     _validateTimeOfAppointment, context),
            Text(
              "Select Week Days",
              style: TextStyle(
                fontSize: 17,
                fontFamily: "general_sans",
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 70, // Square height for the boxes
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  final day = _days[index];
                  final isSelected = _selectedDays.contains(day);
                  return GestureDetector(
                    onTap: () => _onDayTapped(day),
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? primarycolor : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: isSelected
                                ? primarycolor
                                : primarycolor.withOpacity(0.5)),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "general_sans",
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_validateWeekDays.isNotEmpty) ...[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                width: MediaQuery.of(context).size.width * 0.6,
                child: ShakeWidget(
                  key: Key("value"),
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    _validateWeekDays,
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
            Text(
              "Select Address",
              style: TextStyle(
                fontSize: 17,
                fontFamily: "general_sans",
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Consumer<AddressListProvider>(
              builder: (context, provider, _) {
                final addresses = provider.addresses;

                if (addresses.isEmpty) {
                  return SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(addresses.length, (index) {
                    final address = addresses[index];
                    final title = address.typeOfAddress == 1
                        ? "Current Address"
                        : "Permanent Address";

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: selectedAddressIndex == index
                                ? Colors.blue.shade50
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  value: selectedAddressIndex == index,
                                  activeColor: primarycolor,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedAddressIndex =
                                          value == true ? index : null;
                                      address_id = address.id;
                                      _validateLocation = "";
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  title: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "general_sans",
                                      color: Colors.blueGrey[800],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "${address.flatNo}, ${address.street}, ${address.area} - ${address.landmark}, ${address.pincode}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "general_sans",
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
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
                height: 48,
                child: Consumer<BookingHistoryProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (!provider.isSubmitting) {
                          _validateFields();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primarycolor, // Updated button color
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0, // Adds a slight shadow for better UI
                      ),
                      child: provider.isSubmitting
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Text(
                              "Book Appointment",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Epi',
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showChildListBottomSheet(BuildContext context) {
    final childProvider = Provider.of<ChildProvider>(context, listen: false);
    childProvider.getChildList(); // Fetch child list
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Consumer<ChildProvider>(
          builder: (context, provider, _) {
            String? selectedChildId;
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Patient',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'general_sans',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          _showAddEditChildBottomSheet(context, isEdit: false);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: primarycolor),
                          foregroundColor: primarycolor,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Add Patient',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'general_sans',
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  provider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: primarycolor,
                          strokeWidth: 1,
                        ))
                      : provider.childDataList.isEmpty
                          ? Text(
                              'No Patient added yet.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontFamily: 'general_sans',
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: provider.childDataList.length,
                                itemBuilder: (context, index) {
                                  final child = provider.childDataList[index];
                                  final isSelected =
                                      selectedChildId == child.id;
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: isSelected
                                          ? BorderSide(
                                              color: primarycolor, width: 2)
                                          : BorderSide(
                                              color: Colors.transparent),
                                    ),
                                    elevation: 2,
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: ListTile(
                                      onTap: () async {
                                        setState(() {
                                          selectedChildId = child.id.toString();
                                        });
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                        await provider.getChildDetails(child.id
                                            .toString()); // Fetch details
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            primarycolor.withOpacity(0.1),
                                        child: Text(
                                          child.name?[0].toUpperCase() ?? 'C',
                                          style: TextStyle(
                                            fontFamily: 'general_sans',
                                            color: primarycolor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        child.name ?? 'Unknown',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: primarycolor,
                                          fontFamily: 'general_sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Age: ${child.age ?? 'N/A'}, ${child.gender ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'general_sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton.filled(
                                            onPressed: () {
                                              _showAddEditChildBottomSheet(
                                                context,
                                                isEdit: true,
                                                child: child,
                                              );
                                            },
                                            icon: Icon(Icons.edit, size: 18),
                                            style: IconButton.styleFrom(
                                              backgroundColor:
                                                  primarycolor.withOpacity(0.1),
                                              foregroundColor: primarycolor,
                                              padding: EdgeInsets.all(8),
                                              minimumSize: Size(36, 36),
                                            ),
                                            tooltip: 'Edit',
                                          ),
                                          SizedBox(width: 8),
                                          IconButton.filled(
                                            onPressed: () async {
                                              final result =
                                                  await provider.deleteChild(
                                                      child.id.toString());
                                              if (result?.status == true) {
                                                provider.getChildList();
                                              }
                                            },
                                            icon: Icon(Icons.delete, size: 18),
                                            style: IconButton.styleFrom(
                                              backgroundColor:
                                                  Colors.red.shade50,
                                              foregroundColor: Colors.red,
                                              padding: EdgeInsets.all(8),
                                              minimumSize: Size(36, 36),
                                            ),
                                            tooltip: 'Delete',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddEditChildBottomSheet(BuildContext context,
      {bool isEdit = false, ChildData? child}) {
    final nameController =
        TextEditingController(text: isEdit ? child?.name : '');
    final ageController =
        TextEditingController(text: isEdit ? child?.age?.toString() : '');
    String? selectedGender = isEdit ? child?.gender : "Male";
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEdit ? 'Edit Patient' : 'Add Patient',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'general_sans',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: nameController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "general_sans"),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "general_sans"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Normal border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Focused border
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: "general_sans",
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: ageController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "general_sans"),
                        decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "general_sans"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Normal border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Focused border
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: "general_sans",
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Age';
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return 'Please Enter A Valid Age';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'general_sans',
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Male',
                                  groupValue: selectedGender,
                                  activeColor: primarycolor,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Male',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'general_sans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Female',
                                  groupValue: selectedGender,
                                  activeColor: primarycolor,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Female',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'general_sans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (selectedGender == null &&
                          formKey.currentState?.validate() == false)
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 4),
                          child: Text(
                            'Please select a gender',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 24),
                      Consumer<ChildProvider>(
                        builder: (context, provider, _) {
                          return ElevatedButton(
                            onPressed: provider.isLoading
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate() &&
                                        selectedGender != null) {
                                      final data = {
                                        'name': nameController.text,
                                        'age': ageController.text,
                                        'gender': selectedGender,
                                      };
                                      SuccessModel? result;
                                      if (isEdit && child?.id != null) {
                                        result = await provider.editChild(
                                            data, child!.id.toString());
                                      } else {
                                        result = await provider.addChild(data);
                                      }
                                      if (result?.status == true) {
                                        provider.getChildList();
                                        Navigator.pop(context);
                                        showAnimatedTopSnackBar(
                                          context,
                                          isEdit
                                              ? 'Child updated successfully'
                                              : 'Child added successfully',
                                        );
                                      } else {
                                        showAnimatedTopSnackBar(
                                            context, 'Operation failed');
                                      }
                                    } else if (selectedGender == null) {
                                      setState(
                                          () {}); // Trigger validation message
                                    }
                                  },
                            child: provider.isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1,
                                  )
                                : Text(
                                    isEdit ? 'Update Patient' : 'Add Patient',
                                    style: TextStyle(
                                        fontFamily: "general_sans",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 48),
                                backgroundColor: primarycolor,
                                disabledBackgroundColor: primarycolor,
                                disabledForegroundColor: primarycolor,
                                foregroundColor: primarycolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String validation,
    TextInputType keyboardType, [
    String? pattern,
    bool? read_only,
    Function(String)? onChanged, // <-- new
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          readOnly: read_only ?? false,
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: keyboardType,
          onChanged: onChanged, // <-- use here
          inputFormatters: pattern != null
              ? [FilteringTextInputFormatter.allow(RegExp(pattern))]
              : [],
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            hintText: "Enter your $label",
            hintStyle: TextStyle(
              fontSize: 15,
              letterSpacing: 0,
              height: 1.2,
              color: Color(0xffAFAFAF),
              fontFamily: "general_sans",
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
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
                  fontFamily: "general_sans",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 5),
        ]
      ],
    );
  }

  // Widget _buildDropdownField(
  //     String label,
  //     String? value,
  //     TextEditingController controller,
  //     String validation,
  //     List<String> options) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontFamily: 'general_sans',
  //           fontWeight: FontWeight.w500,
  //           color: Color(0xFF374151),
  //         ),
  //       ),
  //       const SizedBox(height: 4),
  //       DropdownButtonFormField<String>(
  //         value: value,
  //         decoration: InputDecoration(
  //           filled: true,
  //           fillColor: Color(0xffffffff),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //             borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //             borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
  //           ),
  //         ),
  //         hint: Align(
  //           alignment: Alignment.center,
  //           child: Text(
  //             "Select appointment",
  //             style: TextStyle(
  //               fontSize: 15,
  //               letterSpacing: 0,
  //               color: Color(0xffAFAFAF),
  //               fontFamily: 'Poppins',
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ),
  //         items: options.map((String option) {
  //           return DropdownMenuItem<String>(
  //             value: option,
  //             child: Text(option),
  //           );
  //         }).toList(),
  //         onChanged: (String? newValue) {
  //           setState(() {
  //             controller.text = newValue!;
  //             appointment = newValue;
  //           });
  //         },
  //         onSaved: (String? newValue) {
  //           controller.text = newValue!;
  //           appointment = newValue;
  //         },
  //       ),
  //       if (validation.isNotEmpty) ...[
  //         Container(
  //           alignment: Alignment.topLeft,
  //           margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
  //           width: MediaQuery.of(context).size.width * 0.6,
  //           child: ShakeWidget(
  //             key: Key("value"),
  //             duration: Duration(milliseconds: 700),
  //             child: Text(
  //               validation,
  //               style: TextStyle(
  //                 fontFamily: "Poppins",
  //                 fontSize: 12,
  //                 color: Colors.red,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ] else ...[
  //         SizedBox(height: 15),
  //       ]
  //     ],
  //   );
  // }

  Widget _buildDateField(String label, TextEditingController controller,
      String validation, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'general_sans',
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
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontFamily: 'general_sans',
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            hintText: "Select your $label",
            hintStyle: TextStyle(
              fontSize: 15,
              letterSpacing: 0,
              height: 1.2,
              color: Color(0xffAFAFAF),
              fontFamily: 'general_sans',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
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
                  fontFamily: 'general_sans',
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ] else ...[
          SizedBox(height: 5),
        ]
      ],
    );
  }

  // Widget _buildTimeField(String label, TextEditingController controller,
  //     String validation, BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontFamily: 'Poppins',
  //           fontWeight: FontWeight.w500,
  //           color: Color(0xFF374151),
  //         ),
  //       ),
  //       const SizedBox(height: 4),
  //       TextFormField(
  //         controller: controller,
  //         cursorColor: Colors.black,
  //         readOnly: true,
  //         onTap: () => _selectTime(context),
  //         decoration: InputDecoration(
  //           hintText: "Select your $label",
  //           hintStyle: TextStyle(
  //             fontSize: 15,
  //             letterSpacing: 0,
  //             height: 1.2,
  //             color: Color(0xffAFAFAF),
  //             fontFamily: 'Poppins',
  //             fontWeight: FontWeight.w400,
  //           ),
  //           filled: true,
  //           fillColor: Color(0xffffffff),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //             borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //             borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
  //           ),
  //         ),
  //       ),
  //       if (validation.isNotEmpty) ...[
  //         Container(
  //           alignment: Alignment.topLeft,
  //           margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
  //           width: MediaQuery.of(context).size.width * 0.6,
  //           child: ShakeWidget(
  //             key: Key("value"),
  //             duration: Duration(milliseconds: 700),
  //             child: Text(
  //               validation,
  //               style: TextStyle(
  //                 fontFamily: "Poppins",
  //                 fontSize: 12,
  //                 color: Colors.red,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ] else ...[
  //         SizedBox(height: 15),
  //       ]
  //     ],
  //   );
  // }
}
