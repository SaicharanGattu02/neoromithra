import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import '../Dashboard.dart';

class ApointmentSuccess extends StatefulWidget {
  const ApointmentSuccess({super.key});

  @override
  State<ApointmentSuccess> createState() => _ApointmentSuccessState();
}

class _ApointmentSuccessState extends State<ApointmentSuccess> {
  @override
  Widget build(BuildContext context) {
    // Disable back navigation
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/sucessfully.json',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 20),
              Text(
                "Appointment Booking Successfully",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Navigate to Dashboard after a delay
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Dashboard()));
      });
    });
  }
}
