import 'package:flutter/material.dart';

import '../services/userapi.dart';

class PaymentStatusScreen extends StatefulWidget {
  final Map<dynamic, dynamic> response;
  final String transactionId;
  final String amount;
  final bool isExistingPatient;
  final String userId;
  final String fullName;
  final String phoneNumber;
  final String appointment;
  final String age;
  final String appointmentType;
  final String date;
  final String timeOfAppointment;
  final String addressId;
  final String pageSource;
  final String patientId;
  final Function onSuccess;

  PaymentStatusScreen({
    required this.response,
    required this.transactionId,
    required this.amount,
    required this.isExistingPatient,
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.appointment,
    required this.age,
    required this.appointmentType,
    required this.date,
    required this.timeOfAppointment,
    required this.addressId,
    required this.pageSource,
    required this.patientId,
    required this.onSuccess,
  });

  @override
  _PaymentStatusScreenState createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  bool _isLoading = true;
  bool _isSuccess = false;
  @override
  void initState() {
    super.initState();
    _handlePaymentResponse();
  }

  void _handlePaymentResponse() async {
    String? status = widget.response["status"];
    if (status == "SUCCESS") {
      _isSuccess = true;
      await _bookAppointment();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _bookAppointment() async {
    Map<String, dynamic> orderData = {
      "amount": widget.amount,
      "transactionID": widget.transactionId,
    };

    bool success;
    if (widget.isExistingPatient) {
      success = await ExistBookAppointment(orderData);
    } else {
      success = await NewBookAppointment(orderData);
    }

    if (success) {
      await Future.delayed(Duration(seconds: 1));
      widget.onSuccess();
    } else {
      setState(() {
        _isLoading = false;
        _isSuccess = false;
      });
    }
  }

  Future<bool> NewBookAppointment(Map<String, dynamic> orderData) async {
    final data = await Userapi.newApointment(
        widget.fullName,
        widget.phoneNumber,
        widget.appointment,
        widget.age,
        widget.appointmentType,
        widget.date,
        widget.addressId,
        widget.pageSource,
        widget.timeOfAppointment,
        widget.userId,
        orderData);
    return data != null && data.status == true;
  }

  Future<bool> ExistBookAppointment(Map<String, dynamic> orderData) async {
    final data = await Userapi.existApointment(
        widget.fullName,
        widget.phoneNumber,
        widget.appointment,
        widget.age,
        widget.appointmentType,
        widget.date,
        widget.addressId,
        widget.pageSource,
        widget.timeOfAppointment,
        widget.userId,
        widget.patientId,
        orderData);
    return data != null && data.status == true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isSuccess, // Disable back button when success
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: _isLoading && _isSuccess
              ? CircularProgressIndicator() // Show loading during API call
              : AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isSuccess
                    ? [Colors.green[50]!, Colors.green[100]!]
                    : [Colors.red[50]!, Colors.red[100]!],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    _isSuccess ? Icons.check_circle : Icons.error,
                    key: ValueKey(_isSuccess),
                    color: _isSuccess ? Colors.green[600] : Colors.red[600],
                    size: 120,
                  ),
                ),
                SizedBox(height: 24),
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 600),
                  child: Text(
                    _isSuccess ? "Payment Successful!" : "Payment Failed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Transaction ID: ${widget.transactionId}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    backgroundColor: _isSuccess
                        ? Colors.green[600]
                        : Colors.red[600]!,
                  ),
                  child: Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
