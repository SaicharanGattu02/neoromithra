import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'dart:convert' show base64Encode, jsonEncode, utf8;
import 'dart:developer';
import 'package:crypto/crypto.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String environment = "PRODUCTION"; // Change to "SANDBOX" for testing
  // final String appId = "M2263C04721G1"; // Merchant ID
  // final String merchantId = "M2263C04721G1";
  // final String saltKey = "a52dde56-568b-4243-8ae1-7065b1169b39";
  final String appId = "M22VFKF2FH2O5"; // Merchant ID
  final String merchantId = "M22VFKF2FH2O5";
  final String saltKey = "bf44dc82-e132-45b3-9f00-d952d6b92453";
  final int saltIndex = 1;
  final String callbackUrl = "";
  final String apiEndPoint = "/pg/v1/pay";

  @override
  void initState() {
    super.initState();
    PhonePePaymentSdk.init(environment, appId, merchantId, true);
  }

  Future<void> initiateTransaction(int amount) async {
    try {
      String transactionId = "TXN_${DateTime.now().millisecondsSinceEpoch}";
      Map<String, dynamic> payload = {
        "merchantTransactionId": transactionId,
        "merchantId": merchantId,
        "amount": amount * 100, // Convert to paisa
        "callbackUrl": callbackUrl,
        "mobileNumber": "9876543210",
        "paymentInstrument": {"type": "PAY_PAGE"}
      };

      log(payload.toString());
      String payloadEncoded = base64Encode(utf8.encode(jsonEncode(payload)));
      var byteCodes = utf8.encode(payloadEncoded + apiEndPoint + saltKey);
      String checksum = "${sha256.convert(byteCodes)}###$saltIndex";

      Map<dynamic, dynamic>? response = await PhonePePaymentSdk.startTransaction(
        payloadEncoded,
        callbackUrl,
        checksum,
        environment,
      );

      if (response != null) {
        String? status = response["status"];
        if (status == "SUCCESS") {
          log("✅ Payment Success: $response");
          _showSnackBar("Payment Successful!");
        } else {
          log("❌ Payment Failed: $response");
          _showSnackBar("Payment Failed!");
        }
      } else {
        log("⚠️ Payment response is null");
        _showSnackBar("Payment response is null");
      }
    } catch (e) {
      log("🚨 Error: $e");
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
          onPressed: () => initiateTransaction(1),
          child: Text("Pay with PhonePe"),
        ),
      ),
    );
  }
}

