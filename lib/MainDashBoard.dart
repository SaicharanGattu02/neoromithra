import 'package:flutter/material.dart';

class MainDashBoard extends StatefulWidget {
  const MainDashBoard({super.key});

  @override
  State<MainDashBoard> createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                'assets/neuromitralogo.png',
                fit: BoxFit.contain,
                scale: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Afternoon',
                    style: TextStyle(color: Color(0xff371B34), fontSize: 14,fontFamily: 'Epi'),
                  ),
                  Text(
                    'Sarina!',
                    style: TextStyle(
                        color: Color(0xff371B34),
                        fontSize: 14,
                        fontFamily: 'Epi',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.notifications_active_sharp),
          )
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [],),
      ),
    );
  }
}
