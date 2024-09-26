import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String customerName;
  final int rating;
  final String review;

  ReviewCard({
    required this.customerName,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              // Use the first letter of the customer's name
              child: Text(
                customerName.isNotEmpty ? customerName[0].toUpperCase() : '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              backgroundColor: Colors.blue, // Customize the background color
              radius: 30,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                  SizedBox(height: 4.0),
                  Text(review),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
