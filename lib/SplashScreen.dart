import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:neuromithra/Dashboard.dart';
import 'package:neuromithra/LogIn.dart';
import 'package:neuromithra/MainDashBoard.dart';
import 'package:neuromithra/Register.dart';
import 'package:neuromithra/services/Preferances.dart';

import 'BookAppointment.dart';
import 'HomeScreen.dart';
import 'OnBoardScreen.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String userId = "";
  String Status = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _fetchDetails();
    // Navigate only if the widget is still mounted
    if (!mounted) return;

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Status == ''? OnBoardScreen():userId.isNotEmpty ?MainDashBoard() : LogIn(),
        ),
      );
    });
  }

  Future<void> _fetchDetails() async {
    String token = await PreferenceService().getString('token') ?? "";
    var status = await PreferenceService().getString('on_boarding');
    setState(() {
      Status = status ?? '';
      userId = token;
    });
    debugPrint("Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensures consistent background color
      body: Center(
        child: Image.asset(
          "assets/neuromitralogo.png",
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
