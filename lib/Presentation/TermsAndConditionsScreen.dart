import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            color: Color(0xff3EA4D2),
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: Color(0xff3EA4D2)), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100], // Light background for contrast
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Terms Content with Card-like styling
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('1. Introduction'),
                    _buildSectionContent(
                      'Welcome to Neuromitra. By accessing or using our services, you agree to be bound by these Terms and Conditions. Please read them carefully.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('2. Services'),
                    _buildSectionContent(
                      'Neuromitra provides a platform to connect users with certified professional therapists for mental health and wellness therapies and counsellings.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('3. User Responsibilities'),
                    _buildSectionContent(
                      'Users are required to provide accurate personal information during registration and adhere to our cancellation and rescheduling policies.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('4. Payment & Fees'),
                    _buildSectionContent(
                      'All payments are processed securely through our payment gateway. Additional service charges may apply as outlined during booking.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('5. No Medical Advice'),
                    _buildSectionContent(
                      'Neuromitra is not a substitute for professional medical advice, diagnosis, or emergency services. Consult a healthcare provider for medical concerns.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('6. Changes to Terms'),
                    _buildSectionContent(
                      'We reserve the right to modify these terms at any time. Updates will be posted here, and continued use constitutes acceptance of changes.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Footer Note
              Center(
                child: Text(
                  'For questions, contact us at neuromitra@gmail.com ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
          fontFamily: "Inter"
      ),
    );
  }

  // Helper method for section content
  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 14,
        height: 1.6, // Improved line spacing
        color: Colors.black54,
          fontFamily: "Inter"
      ),
    );
  }
}