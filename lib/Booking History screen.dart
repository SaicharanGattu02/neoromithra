import 'package:flutter/material.dart';
class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
      ),
      body: ListView.builder(
        itemCount: 5,  // Replace with the number of bookings you have
        itemBuilder: (context, index) {
          return BookingCard(
            therapistName: 'Therapist ${index + 1}',
            bookingDate: 'Sep 20, 2024',
            bookingTime: '2:00 PM',
            status: 'Confirmed',
          );
        },
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String therapistName;
  final String bookingDate;
  final String bookingTime;
  final String status;

  BookingCard({
    required this.therapistName,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Therapist Name
            Text(
              therapistName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            // Booking Date
            Text(
              'Date: $bookingDate',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),

            // Booking Time
            Text(
              'Time: $bookingTime',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),

            // Status
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 16,
                color: status == 'Confirmed' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
