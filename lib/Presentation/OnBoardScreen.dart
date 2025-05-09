import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/services/Preferances.dart';

import '../utils/Color_Constants.dart';
import 'Authentication/LogIn.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}


class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  void initState() {
    PreferenceService().saveString('on_boarding', '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          // Image.asset(
          //   "assets/onboardbg.png",
          //   fit: BoxFit.cover,
          // ),
          ClipOval(
            child: Image.asset(
              "assets/applogo.jpeg",
              width: 150,
              height: 150,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// **Welcome Title**
                  const Text(
                    "Welcome to NeuroMitra",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Epi",
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// **Tagline**
                  const Text(
                    "Empowering minds, enriching lives",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Epi",
                      color: primarycolor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// **Main Description**
                  const Text(
                    "Your Partner in Understanding & Supporting Neurodiverse Kids and Adults.\n\n"
                        "From children with developmental delays to adults seeking mental wellness, we’re here for you.\n\n"
                        "We provide expert guidance, therapy access, and support for parents of children with autism, ADHD, and other psychological conditions.\n\n"
                        "We believe in empowering Neurodiverse Minds & Mental Wellness for All.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Epi",
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// **Continue Button**
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  primarycolor, // Button background
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        elevation: 3, // Slight shadow for better UI
                      ),
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Epi",
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
