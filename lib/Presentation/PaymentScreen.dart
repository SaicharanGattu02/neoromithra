import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String environment = "SANDBOX";
  final String appId = "YOUR_APP_ID";
  final String merchantId = "YOUR_MERCHANT_ID";
  final String saltKey = "YOUR_SALT_KEY";
  final String saltIndex = "YOUR_SALT_INDEX";

  @override
  void initState() {
    super.initState();
    PhonePePaymentSdk.init(environment,appId,merchantId,true);
  }

  Future<void> initiateTransaction() async {
    try {
      String transactionId = "TXN_${DateTime.now().millisecondsSinceEpoch}";
      int amount = 10000;
      String callbackUrl = "https://yourserver.com/callback";

      Map<String, dynamic> payload = {
        "merchantTransactionId": transactionId,
        "merchantId": "YOUR_MERCHANT_ID",
        "amount": amount,
        "callbackUrl": callbackUrl,
        "mobileNumber": "9876543210",
        "paymentInstrument": {
          "type": "UPI_INTENT",
        }
      };

      String payloadString = jsonEncode(payload); // Convert Map to JSON String

      Map<dynamic, dynamic>? response = await PhonePePaymentSdk.startTransaction(
        payloadString, // Pass the JSON string instead of Map
        "YOUR_SALT_KEY",
        "YOUR_SALT_INDEX",
        "SANDBOX", // Change to "PRODUCTION" for live
      );

      if (response != null) {
        String? status = response["status"]; // Extract status from response
        if (status == "SUCCESS") {
          print("Payment Success: $response");
          // Handle success logic (e.g., update UI, store transaction details)
        } else {
          print("Payment Failed: $response");
          // Handle failure (e.g., show error message)
        }
      } else {
        print("Payment response is null");
      }
    } catch (e) {
      print("Error: $e");
    }
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