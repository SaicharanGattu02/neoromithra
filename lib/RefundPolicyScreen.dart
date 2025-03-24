import 'package:flutter/material.dart';

class RefundPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Refund Policy',
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
        height: double.infinity,
        color: Colors.grey[100], // Light background for contrast
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
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
                    _buildSectionTitle('1. Refund Eligibility'),
                    _buildSectionContent(
                      'Cancellations made at least 24 hours prior to the scheduled session are eligible for a full refund. Requests must be submitted through the app or website.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('2. Non-Refundable Cases'),
                    _buildSectionContent(
                      'No refunds will be issued for cancellations within 24 hours of the session, no-shows, or sessions that have already been completed.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('3. Processing Time'),
                    _buildSectionContent(
                      'Approved refunds will be processed within 5-7 business days and credited back to the original payment method.',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('4. Rescheduling Policy'),
                    _buildSectionContent(
                      'Sessions can be rescheduled without penalty if requested at least 12 hours before the appointment time, subject to therapist availability.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Footer Note
              Center(
                child: Text(
                  'For refund inquiries, contact neuromitra@gmail.com ',
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