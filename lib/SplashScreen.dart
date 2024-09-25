import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:neuromithra/Dashboard.dart';
import 'package:neuromithra/Register.dart';
import 'package:neuromithra/services/Preferances.dart';

import 'BookAppointment.dart';
import 'HomeScreen.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String User_id="";
  String status="";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        if(User_id!=""){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>Dashboard()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>Register()));
        }

      });
    });
    Fetchdetails();
  }
  Fetchdetails() async {
    var token = (await PreferenceService().getString('token'))??"";
    // var status = (await PreferenceService().getString('onboard_status'))??"";
    setState(() {
      User_id=token;
    });
    print("Token:${token}");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            height: screenheight,
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                width: 260,
                height: 150,
                fit:BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
