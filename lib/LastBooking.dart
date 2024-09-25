import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuromithra/AddRating.dart';
import 'package:neuromithra/services/userapi.dart';

import 'Model/BookingHistoryModel.dart';

class LastBooking extends StatefulWidget {
  const LastBooking({super.key});

  @override
  State<LastBooking> createState() => _LastBookingState();
}

class _LastBookingState extends State<LastBooking> {
  @override
  void initState() {
    GetBookingHistory();
    super.initState();
  }
  List<BookingHistory> bookingHistory=[];
  Future<void> GetBookingHistory() async {
    final Response = await Userapi.getbookinghistory();
    if (Response != null) {
      setState(() {
        if(Response.status==true){
          bookingHistory = Response.bookingHistory??[];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    // Sample list of bookings (can be replaced with dynamic data)
    // List<Map<String, String>> bookings = [
    //   {"order": "#24856", "type": "Online", "time": "11:00 - 12:00 AM", "date": "Sunday, 12 June"},
    //   {"order": "#24857", "type": "Self", "time": "12:00 - 1:00 PM", "date": "Monday, 13 June"},
    //   // Add more bookings here...
    // ];
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
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10.0,
            childAspectRatio: 2.35,
          ),
          itemCount: bookingHistory.length,
          itemBuilder: (BuildContext context, int index) {
            var booking = bookingHistory[index];
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
                        "Order No-${booking.id}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
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
                          "${booking.appointmentType}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0,
                            color: Color(0xff0DC613),
                            fontWeight: FontWeight.w700,
                            height: 13.64 / 10.0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 32,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                        decoration: BoxDecoration(
                            color: Color(0x80A0F2F0),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "${booking.appointment}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Color(0xff088A87),
                            fontWeight: FontWeight.w700,
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
                        "${booking.dateOfAppointment}",
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
                        "${booking.timeOfAppointment}",
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
                  Divider(
                    thickness: 0.5,
                  ),
                  InkResponse(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProductRating(app_id: booking.id, page_source: booking.pageSource)),
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star,color: Colors.yellow,),
                          SizedBox(width: 5,),
                          Text("Rate us",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:FontWeight.w500,
                            fontFamily: "Inter"
                          ),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
