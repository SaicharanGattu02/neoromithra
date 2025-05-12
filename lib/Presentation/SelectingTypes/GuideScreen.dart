import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:neuromithra/Assesment/AdultAssignment.dart';

import '../../Assesment/ChildAssessment.dart';
import '../../Components/CustomAppButton.dart';
import '../../services/AuthService.dart';
import '../../utils/Color_Constants.dart';
import 'Selecting_types.dart';

class Guidescreen extends StatefulWidget {
  const Guidescreen({super.key});

  @override
  State<Guidescreen> createState() => _GuidescreenState();
}

class _GuidescreenState extends State<Guidescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simple Guide',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
            color: primarycolor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.push("/selecting_type");
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/applogo.jpeg',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            'About NeuroMitra',
                            style: TextStyle(
                              fontFamily: "general_sans",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(LucideIcons.arrowRight,
                            color: primarycolor, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder<bool>(
                future: AuthService.isGuest,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(); // Show nothing or a loader until we know
                  }
                  final isGuest = snapshot.data!;
                  if (!isGuest) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          'For Children:',
                          style: TextStyle(
                            fontFamily: "general_sans",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            context.push("/child_guide");
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/children.jpg',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Support Guide for Children',
                                      style: TextStyle(
                                        fontFamily: "general_sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(LucideIcons.arrowRight,
                                      color: primarycolor, size: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'For Adults:',
                          style: TextStyle(
                            fontFamily: "general_sans",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            context.push("/adult_guide");
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/adult1.webp', // Replace with actual asset image
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Support Guide for an Adult',
                                      style: TextStyle(
                                        fontFamily: "general_sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(LucideIcons.arrowRight,
                                      color: primarycolor, size: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return SizedBox(); // Hide the block for guests or when status is true
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
