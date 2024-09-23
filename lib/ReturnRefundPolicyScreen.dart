import 'package:flutter/material.dart';

class ReturnRefundPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return and Refund Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Return Policy'),
            _buildSection('1. Eligibility for Returns:'),
            _buildBulletPoint('Timeframe: Returns must be initiated within [30/60] days from the date of delivery.'),
            _buildBulletPoint('Condition: Items must be in their original condition, unused, and with all original packaging and tags intact.'),
            _buildBulletPoint('Exceptions: Custom or personalized items, perishable goods, and items marked as non-returnable cannot be returned.'),
            _buildSection('2. How to Initiate a Return:'),
            _buildBulletPoint('Contact Us: To start a return, please contact our customer service team at [Your Contact Information] to request a Return Merchandise Authorization (RMA) number.'),
            _buildBulletPoint('Return Shipping: Once you receive your RMA number, pack the item securely in its original packaging and ship it back to us at the address provided by our team. The cost of return shipping is the responsibility of the customer unless the return is due to a mistake on our part.'),
            _buildSection('3. Inspection and Processing:'),
            _buildBulletPoint('Inspection: Upon receiving your returned item, we will inspect it to ensure it meets our return policy criteria.'),
            _buildBulletPoint('Processing Time: Refunds are processed within [5-7] business days after the return is approved.'),

            _buildSectionTitle('Refund Policy'),
            _buildSection('1. Refunds for Returned Items:'),
            _buildBulletPoint('Refund Method: Refunds will be issued to the original payment method used for the purchase.'),
            _buildBulletPoint('Partial Refunds: In some cases, a partial refund may be issued if the returned item is not in its original condition or is missing parts.'),
            _buildSection('2. Non-Refundable Items:'),
            _buildBulletPoint('Certain items are non-refundable, including but not limited to:'),
            _buildBulletPoint('Custom or personalized items'),
            _buildBulletPoint('Perishable goods'),
            _buildBulletPoint('Clearance items'),
            _buildSection('3. Shipping Costs:'),
            _buildBulletPoint('Initial Shipping Costs: Shipping fees paid at the time of purchase are non-refundable.'),
            _buildBulletPoint('Return Shipping Costs: The cost of return shipping is the responsibility of the customer, except in cases of defective or incorrect items.'),

            _buildSectionTitle('Exchanges'),
            _buildBulletPoint('Currently, we do not offer direct exchanges. If you need a different item, please return the original item and place a new order.'),

            _buildSectionTitle('Damaged or Incorrect Items'),
            _buildSection('1. Damaged Items:'),
            _buildBulletPoint('If you receive a damaged or defective item, please contact us immediately at [Your Contact Information] with details and photos of the damage. We will arrange for a replacement or refund at no additional cost to you.'),
            _buildSection('2. Incorrect Items:'),
            _buildBulletPoint('If you receive an incorrect item, please contact us within [7] days of receipt. We will provide instructions for returning the incorrect item and will send you the correct item at no extra charge.'),

            _buildSectionTitle('Changes to the Policy'),
            _buildBulletPoint('We reserve the right to update or modify this Return and Refund Policy at any time. Changes will be posted on this page with the updated effective date.'),

            _buildSectionTitle('Contact Us'),
            _buildBulletPoint('For any questions or concerns regarding our Return and Refund Policy, please contact us at:'),
            _buildBulletPoint('Email: [info@neuromitra.in]'),
            _buildBulletPoint('Phone: [+91 8885320115]'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSection(String section) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        section,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildBulletPoint(String point) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 16),
          SizedBox(width: 8),
          Expanded(child: Text(point)),
        ],
      ),
    );
  }
}
