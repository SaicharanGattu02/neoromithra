import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/Color_Constants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
            color: primarycolor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () => context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle('1. Introduction'),
              buildSectionContent(
                'Welcome to Neuromitra. By accessing or using our services, you agree to be bound by these Terms and Conditions. Please read them carefully.',
              ),
              buildSpacer(),

              buildSectionTitle('2. Services'),
              buildSectionContent(
                'Neuromitra provides a platform to connect users with certified professional therapists for mental health and wellness therapies and counselling.',
              ),
              buildSpacer(),

              buildSectionTitle('3. User Responsibilities'),
              buildSectionContent(
                'Users are required to provide accurate personal information during registration and adhere to our cancellation and rescheduling policies.',
              ),
              buildSpacer(),

              buildSectionTitle('4. Payment & Fees'),
              buildSectionContent(
                'All payments are processed securely through our payment gateway. Additional service charges may apply as outlined during booking.',
              ),
              buildSpacer(),

              buildSectionTitle('5. No Medical Advice'),
              buildSectionContent(
                'Neuromitra is not a substitute for professional medical advice, diagnosis, or emergency services. Consult a healthcare provider for medical concerns.',
              ),
              buildSpacer(),

              buildSectionTitle('6. Changes to Terms'),
              buildSectionContent(
                'We reserve the right to modify these terms at any time. Updates will be posted here, and continued use constitutes acceptance of changes.',
              ),
              const SizedBox(height: 24),

              Center(
                child: Text(
                  'For questions, contact us at neuromitra@gmail.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontFamily: "general_sans",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Section Title
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: "general_sans",
        color: Color(0xFF222222),
      ),
    );
  }

  // 🔹 Section Content
  Widget buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 15.5,
          height: 1.6,
          fontWeight: FontWeight.w400,
          fontFamily: "general_sans",
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildSpacer() => const SizedBox(height: 24);
}
