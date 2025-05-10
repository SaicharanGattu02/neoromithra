import 'package:flutter/material.dart';

import '../utils/Color_Constants.dart';

class RefundPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text(
          'Refund Policy',
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
          onPressed: () => Navigator.pop(context),
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
              buildSectionTitle('1. Refund Eligibility'),
              buildSectionContent(
                'Cancellations made at least 24 hours prior to the scheduled session are eligible for a full refund. Requests must be submitted through the app or website.',
              ),
              buildSpacer(),

              buildSectionTitle('2. Non-Refundable Cases'),
              buildSectionContent(
                'No refunds will be issued for cancellations within 24 hours of the session, no-shows, or sessions that have already been completed.',
              ),
              buildSpacer(),

              buildSectionTitle('3. Processing Time'),
              buildSectionContent(
                'Approved refunds will be processed within 5–7 business days and credited back to the original payment method.',
              ),
              buildSpacer(),

              buildSectionTitle('4. Rescheduling Policy'),
              buildSectionContent(
                'Sessions can be rescheduled without penalty if requested at least 12 hours before the appointment time, subject to therapist availability.',
              ),
              const SizedBox(height: 24),

              Center(
                child: Text(
                  'For refund inquiries, contact neuromitra@gmail.com',
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
