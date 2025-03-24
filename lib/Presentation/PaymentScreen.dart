import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String environment = "PRODUCTION"; // Change to "SANDBOX" for testing
  final String appId = "M2263C04721G1"; // Merchant ID
  final String merchantId = "M2263C04721G1";
  final String saltKey = "a52dde56-568b-4243-8ae1-7065b1169b39";
  final String saltIndex = "1";
  final String callbackUrl = "http://192.168.0.61:8080/phonepe/callback";
  final String baseUrl = "https://api.phonepe.com/apis/hermes/pg/v1"; // Production Base URL

  @override
  void initState() {
    super.initState();
    PhonePePaymentSdk.init(environment, appId, merchantId, true);
  }
  Future<void> initiateTransaction() async {
    try {
      String transactionId = "TXN_${DateTime.now().millisecondsSinceEpoch}";
      int amount = 10000; // Amount in paise (100.00 INR)

      Map<String, dynamic> payload = {
        "merchantTransactionId": transactionId,
        "merchantId": merchantId,
        "amount": amount,
        "callbackUrl": callbackUrl,
        "mobileNumber": "9876543210",
        "paymentInstrument": {
          "type": "UPI_INTENT",
        }
      };

      String payloadString = jsonEncode(payload); // Convert Map to JSON String


      Map<dynamic, dynamic>? response = await PhonePePaymentSdk.startTransaction(
        payloadString, // JSON String instead of Map
        saltKey,
        saltIndex,
        environment,
      );

      if (response != null) {
        String? status = response["status"]; // Extract payment status
        if (status == "SUCCESS") {
          print("✅ Payment Success: $response");
          _showSnackBar("Payment Successful!");
        } else {
          print("❌ Payment Failed: $response");
          _showSnackBar("Payment Failed!");
        }
      } else {
        print("⚠️ Payment response is null");
        _showSnackBar("Payment response is null");
      }
    } catch (e) {
      print("🚨 Error: $e");
      _showSnackBar("Error: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PhonePe Payment")),
      body: Center(
        child: ElevatedButton(
          onPressed: initiateTransaction,
          child: Text("Pay with PhonePe"),
        ),
      ),
    );
  }
}
