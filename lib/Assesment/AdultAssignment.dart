import 'package:flutter/material.dart';

class Adultassignment extends StatefulWidget {
  const Adultassignment({super.key});

  @override
  State<Adultassignment> createState() => _AdultassignmentState();
}

class _AdultassignmentState extends State<Adultassignment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adult Development Assessment',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            color: Color(0xff3EA4D2),
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff3EA4D2)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                'Start with Our Simple Guide',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,height: 1),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Go through our guide or schedule a counseling session.Begin your journey toward mental wellness with personalized support.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            const Text(
              'Here’s a simple guide designed to help individuals reflect on different aspects of their lives and identify areas for improvement:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions: For each of the following statements, rate yourself on a scale from 1 to 5, where:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            const Text(
              '1 = Strongly Disagree\n2 = Disagree\n3 = Neutral\n4 = Agree\n5 = Strongly Agree',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
