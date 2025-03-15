import 'package:flutter/material.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Privacy Policy',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: Color(0xff3EA4D2),
                fontSize: 18)),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Personal Information: We may collect personal information that you voluntarily provide to us when you register on the Site, make a purchase, subscribe to our newsletter, or contact us. This may include your name, email address, phone number, and payment information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Non-Personal Information: We may collect non-personal information about you when you interact with our Site, such as your IP address, browser type, operating system, and usage data. This information helps us understand how you use our Site and improve our services.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'How We Use Your Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We use your personal information for the following purposes:\n\n'
                  '- To process transactions and manage your orders.\n'
                  '- To communicate with you about your account, orders, and any updates to our services.\n'
                  '- To provide customer support and respond to your inquiries.\n'
                  '- To send you promotional materials, newsletters, and other information that may be of interest to you (you can opt out of receiving these communications at any time).\n'
                  '- To improve our Site and services based on your feedback and usage patterns.\n'
                  '- To comply with legal obligations and enforce our terms and conditions.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'How We Share Your Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may share your information in the following circumstances:\n\n'
                  '- With Service Providers: We may share your information with third-party service providers who assist us in operating our Site, processing payments, or delivering services. These providers are contractually obligated to protect your information and use it only for the purposes specified by us.\n'
                  '- For Legal Purposes: We may disclose your information if required to do so by law or in response to valid requests from public authorities (e.g., a subpoena or court order).\n'
                  '- Business Transfers: In the event of a merger, acquisition, or sale of all or a portion of our business, your information may be transferred as part of that transaction. We will notify you of any such changes and how they may affect your information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Security of Your Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We implement reasonable security measures to protect your personal information from unauthorized access, use, or disclosure. However, please be aware that no method of transmission over the internet or electronic storage is completely secure. While we strive to protect your information, we cannot guarantee its absolute security.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Your Rights and Choices',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Access and Correction: You have the right to access and update your personal information. If you wish to review or correct any personal information we hold about you, please contact us using the information below.\n\n'
                  '2. Opt-Out: You can opt out of receiving promotional communications from us by following the unsubscribe instructions provided in those communications or by contacting us directly.\n\n'
                  '3. Do Not Track: Our Site does not currently respond to “Do Not Track” signals.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will post any changes on this page and update the effective date at the top. We encourage you to review this Privacy Policy periodically to stay informed about how we are protecting your information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at:\n\n'
                  'Email: neuromitra@gmail.com\n'
                  'Phone: +91 8885320115',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
