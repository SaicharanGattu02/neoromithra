import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/Color_Constants.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FB),
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Container(
          padding: EdgeInsets.all(20),
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
              buildSectionTitle("Information We Collect"),
              buildSectionBody(
                  '1. Personal Information: We may collect personal information that you voluntarily provide to us when you register on the Site, make a purchase, subscribe to our newsletter, or contact us. This may include your name, email address, phone number, and payment information.\n\n'
                      '2. Non-Personal Information: We may collect non-personal information about you when you interact with our Site, such as your IP address, browser type, operating system, and usage data. This information helps us understand how you use our Site and improve our services.'),

              buildSpacer(),

              buildSectionTitle("How We Use Your Information"),
              buildSectionBody(
                  '- To process transactions and manage your orders.\n'
                      '- To communicate with you about your account, orders, and any updates to our services.\n'
                      '- To provide customer support and respond to your inquiries.\n'
                      '- To send you promotional materials, newsletters, and other information that may be of interest to you (you can opt out of receiving these communications at any time).\n'
                      '- To improve our Site and services based on your feedback and usage patterns.\n'
                      '- To comply with legal obligations and enforce our terms and conditions.'),

              buildSpacer(),

              buildSectionTitle("How We Share Your Information"),
              buildSectionBody(
                  '- With Service Providers: We may share your information with third-party service providers who assist us in operating our Site, processing payments, or delivering services. These providers are contractually obligated to protect your information and use it only for the purposes specified by us.\n\n'
                      '- For Legal Purposes: We may disclose your information if required to do so by law or in response to valid requests from public authorities (e.g., a subpoena or court order).\n\n'
                      '- Business Transfers: In the event of a merger, acquisition, or sale of all or a portion of our business, your information may be transferred as part of that transaction. We will notify you of any such changes and how they may affect your information.'),

              buildSpacer(),

              buildSectionTitle("Security of Your Information"),
              buildSectionBody(
                  'We implement reasonable security measures to protect your personal information from unauthorized access, use, or disclosure. However, please be aware that no method of transmission over the internet or electronic storage is completely secure. While we strive to protect your information, we cannot guarantee its absolute security.'),

              buildSpacer(),

              buildSectionTitle("Your Rights and Choices"),
              buildSectionBody(
                  '1. Access and Correction: You have the right to access and update your personal information. If you wish to review or correct any personal information we hold about you, please contact us using the information below.\n\n'
                      '2. Opt-Out: You can opt out of receiving promotional communications from us by following the unsubscribe instructions provided in those communications or by contacting us directly.\n\n'
                      '3. Do Not Track: Our Site does not currently respond to “Do Not Track” signals.'),

              buildSpacer(),

              buildSectionTitle("Changes to This Privacy Policy"),
              buildSectionBody(
                  'We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will post any changes on this page and update the effective date at the top. We encourage you to review this Privacy Policy periodically to stay informed about how we are protecting your information.'),

              buildSpacer(),

              buildSectionTitle("Contact Us"),
              buildSectionBody(
                  'If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at:\n\n'
                      'Email: neuromitra@gmail.com\n'
                      'Phone: +91 8885320115\n'
                      'Address: NEUROMITRA EVOMENTIS PRIVATE LIMITED\nH NO- 3-229, PLOT 3/57, SUBHASH CHANDRABOSE NAGAR,\nMiyapur, Tirumalagiri, Hyderabad-500049, Telangana'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: "general_sans",
        color: Color(0xFF222222),
      ),
    );
  }

  Widget buildSectionBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.5,
          height: 1.6,
          fontWeight: FontWeight.w400,
          fontFamily: "general_sans",
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildSpacer() => SizedBox(height: 24);
}

