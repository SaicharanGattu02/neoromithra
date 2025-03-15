import 'package:flutter/material.dart';

class ShippingPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We strive to provide you with a smooth and efficient shipping experience. This Shipping Policy outlines the shipping methods, costs, processing times, and delivery details for your orders.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Shipping Methods and Costs',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Standard Shipping:\n'
                  '   - Delivery Time: Typically 5-7 business days from the date of shipment.\n'
                  '   - Cost: [Insert cost] or Free on orders over [Insert amount].\n\n'
                  '2. Expedited Shipping:\n'
                  '   - Delivery Time: Typically 2-3 business days from the date of shipment.\n'
                  '   - Cost: [Insert cost].\n\n'
                  '3. Overnight Shipping:\n'
                  '   - Delivery Time: Delivery by the next business day after shipment.\n'
                  '   - Cost: [Insert cost].\n\n'
                  '4. International Shipping:\n'
                  '   - Delivery Time: Varies by destination; typically 7-14 business days.\n'
                  '   - Cost: Rates are calculated at checkout based on destination and package weight.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Order Processing',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Processing Time: Orders are processed within 1-2 business days from receipt. Orders placed on weekends or public holidays will be processed on the next business day.\n\n'
                  'Order Confirmation: You will receive an email confirmation once your order is placed and another email with a tracking number once it has been shipped.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Tracking Your Order',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Once your order has been shipped, you will receive a tracking number via email. You can use this tracking number to monitor the status of your shipment on our [tracking page/website].',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Delivery Issues',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Lost or Delayed Shipments:\n'
                  '   If your order has not arrived within the expected delivery time, please contact us at [Your Contact Information]. We will assist you in locating your package or addressing any issues with the shipping carrier.\n\n'
                  '2. Incorrect Address:\n'
                  '   Please double-check your shipping address before completing your purchase. We are not responsible for delays or issues arising from incorrect or incomplete addresses provided by you.\n\n'
                  '3. Damaged Packages:\n'
                  '   If your package arrives damaged, please contact us immediately with your order number and details of the damage. We will help you with a replacement or refund as appropriate.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'International Orders',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Customs Duties and Taxes:\n'
                  '   International orders may be subject to customs duties, taxes, or other fees imposed by your country’s authorities. These charges are the responsibility of the recipient.\n\n'
                  '2. Customs Delays:\n'
                  '   Customs processing times can vary and may cause delays beyond our control. We are not responsible for any delays caused by customs.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Changes to Shipping Policy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may update our Shipping Policy from time to time. Any changes will be posted on this page, and the effective date will be updated accordingly. We encourage you to review this policy periodically.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or need further assistance regarding our shipping policy, please contact us at:\n\n'
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
