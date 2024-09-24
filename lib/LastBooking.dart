import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastBooking extends StatefulWidget {
  const LastBooking({super.key});

  @override
  State<LastBooking> createState() => _LastBookingState();
}

class _LastBookingState extends State<LastBooking> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    // Sample list of bookings (can be replaced with dynamic data)
    List<Map<String, String>> bookings = [
      {"order": "#24856", "type": "Online", "time": "11:00 - 12:00 AM", "date": "Sunday, 12 June"},
      {"order": "#24857", "type": "Self", "time": "12:00 - 1:00 PM", "date": "Monday, 13 June"},
      // Add more bookings here...
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Color(0xff747474),
        ),
        title: Text(
          "Last Booking",
          style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: "Inter",
              height: 24.2 / 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Number of items per row (you can change to 2 if needed)
            mainAxisSpacing: 20.0, // Spacing between grid items vertically
            crossAxisSpacing: 10.0, // Spacing between grid items horizontally
            childAspectRatio: 2.5, // Aspect ratio for controlling the size of each item
          ),
          itemCount: bookings.length,
          itemBuilder: (BuildContext context, int index) {
            var booking = bookings[index];
            return Container(
              width: w,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0x4DA0F2F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Order ${booking['order']}",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          height: 21.82 / 16.0,
                        ),
                      ),
                      SizedBox(
                        width: w * 0.020,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                            color: Color(0x4DA0F2A3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "${booking['type']}",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 10.0,
                            color: Color(0xff0DC613),
                            fontWeight: FontWeight.w700,
                            height: 13.64 / 10.0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                            color: Color(0x80A0F2F0),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Self",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14,
                            color: Color(0xff088A87),
                            fontWeight: FontWeight.w700,
                            height: 19.01 / 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${booking['date']}",
                        style: TextStyle(
                          fontFamily: 'Poppins', // Font family
                          fontSize: 12.0, // Font size (12px)
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                          height: 18 / 12.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.access_time,
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${booking['time']}",
                        style: TextStyle(
                          fontFamily: 'Poppins', // Font family
                          fontSize: 12.0, // Font size (12px)
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                          height: 18 / 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
