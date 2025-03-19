import 'package:flutter/material.dart';

import '../../Assesment/ChildAssessment.dart';
import '../../Components/CustomAppButton.dart';

class Guidescreen extends StatefulWidget {
  const Guidescreen({super.key});

  @override
  State<Guidescreen> createState() => _GuidescreenState();
}

class _GuidescreenState extends State<Guidescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'For Children:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            CustomAppButton(
              text: 'Support Guide for Children',
              onPlusTap: () {
                Navigator.of(context)
                    .push(PageRouteBuilder(
                  pageBuilder: (context,
                      animation,
                      secondaryAnimation) {
                    return ChildAssessment();
                  },
                  transitionsBuilder:
                      (context,
                      animation,
                      secondaryAnimation,
                      child) {
                    const begin =
                    Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve =
                        Curves.easeInOut;
                    var tween = Tween(
                        begin: begin,
                        end: end)
                        .chain(CurveTween(
                        curve: curve));
                    var offsetAnimation =
                    animation
                        .drive(tween);
                    return SlideTransition(
                        position:
                        offsetAnimation,
                        child: child);
                  },
                ));
              },
            ),
            SizedBox(height: 50),
            // Adults Section
            Text(
              'For Adults:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            CustomAppButton(
              text: 'Support Guide for an Adult',
              onPlusTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
