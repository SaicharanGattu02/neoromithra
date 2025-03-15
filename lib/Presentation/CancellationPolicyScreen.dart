import 'package:flutter/material.dart';

class CancellationPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancellation Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We understand that sometimes plans change. This Cancellation Policy provides details on how you can cancel your order or service, as well as any applicable conditions or fees.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Order Cancellation',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Eligibility for Cancellation:\n'
                  '   - Timeframe: Orders may be canceled within [24/48] hours of placement. After this period, we may not be able to accommodate cancellation requests.\n'
                  '   - Status: Cancellations are only accepted if the order has not yet been processed or shipped. If your order is already in transit, you will need to follow our return process.\n\n'
                  '2. How to Cancel an Order:\n'
                  '   - Contact Us: To cancel an order, please contact our customer service team immediately at [Your Contact Information]. Provide your order number and the reason for cancellation.\n'
                  '   - Confirmation: You will receive a cancellation confirmation email once your request has been processed.\n\n'
                  '3. Refunds for Canceled Orders:\n'
                  '   - Refund Method: Refunds will be issued to the original payment method used for the purchase. Please allow [5-7] business days for the refund to be processed.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Service Cancellation',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Eligibility for Service Cancellation:\n'
                  '   - Timeframe: Service cancellations must be requested at least [48/72] hours before the scheduled appointment or service date.\n'
                  '   - Notification: Please notify us as soon as possible if you need to cancel a service.\n\n'
                  '2. How to Cancel a Service:\n'
                  '   - Contact Us: To cancel a service, contact us at [Your Contact Information] with your booking details and reason for cancellation.\n'
                  '   - Confirmation: You will receive a cancellation confirmation email once your request has been processed.\n\n'
                  '3. Cancellation Fees:\n'
                  '   - Standard Fee: A cancellation fee of [X%] of the total service cost may apply if the cancellation is made less than [48/72] hours before the scheduled appointment or service date.\n'
                  '   - No Fee: No cancellation fee will be charged if the service is canceled more than [48/72] hours in advance.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Changes and Rescheduling',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Rescheduling Requests:\n'
                  '   - Timeframe: If you wish to reschedule an appointment or service, please contact us at least [48/72] hours in advance.\n'
                  '   - Availability: Rescheduling is subject to availability and may incur additional fees depending on the new date and time.\n\n'
                  '2. Change Requests:\n'
                  '   - Fees: Any changes to the order or service details may incur additional charges. We will notify you of any extra costs before processing your request.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Policy Updates',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may update this Cancellation Policy from time to time. Any changes will be posted on this page with the updated effective date. We encourage you to review this policy periodically.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'For questions or further assistance regarding our Cancellation Policy, please contact us at:\n\n'
                  'Email: info@neuromitra.in\n'
                  'Phone: +91 8885320115',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
