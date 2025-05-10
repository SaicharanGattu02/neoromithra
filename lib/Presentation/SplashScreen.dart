import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

import 'package:neuromithra/Presentation/MainDashBoard.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'Authentication/LogIn.dart';
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

    if (!mounted) return;

    Future.delayed(Duration(seconds: 2), () {
      if (Status.isEmpty) {
        context.pushReplacement('/on_boarding');
      } else if (userId.isNotEmpty) {
        context.pushReplacement('/main_dashBoard?initialIndex=${0}');
      } else {
        context.pushReplacement('/login_with_mobile');
      }
    });
  }

  Future<void> _fetchDetails() async {
    String token = await PreferenceService().getString('token') ?? "";
    var status = await PreferenceService().getString('on_boarding');
    setState(() {
      Status = status ?? '';
      debugPrint('Status::${Status}');
      userId = token;
    });
    debugPrint("Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipOval(
          child: Image.asset(
            "assets/applogo.jpeg",
            width: 200,
            height: 200,
            fit: BoxFit.cover, // Ensures the image fills the circular area
          ),
        ),
      ),
    );
  }
}
