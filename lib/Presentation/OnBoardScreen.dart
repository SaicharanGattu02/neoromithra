import 'package:flutter/material.dart';
import 'package:neuromithra/services/Preferances.dart';

import 'LogIn.dart';

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

          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/onboardbg.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/neuromitralogo.png",
                  width: 180,
                  height: 180,
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Your Safe Space for Mental Well-being",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Epi",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Track your mood, build healthy habits, and access expert support whenever you need it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Epi",
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// **Continue Button**
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => LogIn()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3EA4D2), // Background color
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
