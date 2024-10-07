import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/AddRating.dart';
import 'package:neuromithra/services/userapi.dart';

import 'CustomAppBar.dart';
import 'Model/BookingHistoryModel.dart';

class LastBooking extends StatefulWidget {
  const LastBooking({super.key});

  @override
  State<LastBooking> createState() => _LastBookingState();
}

class _LastBookingState extends State<LastBooking> {
  bool is_loading=true;
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
          is_loading=false;
          bookingHistory = Response.bookingHistory??[];
        }else{
          is_loading=false;
        }
      });
    }
  }

  Future<void> downloadscript() async {
    final Response = await Userapi.downloadscriptapi();
    if (Response != null) {
      setState(() {

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
      appBar: CustomAppBar(
        title: 'Booking History',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body:(is_loading)?Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ):
      (bookingHistory.length==0)?
      Center(
        child: Lottie.asset(
          'assets/animations/nodata1.json',
          height: 360,
          width: 360,
        ),
      ):
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child:ListView.builder(
          shrinkWrap: true,
          itemCount: bookingHistory.length,
          itemBuilder: (BuildContext context, int index) {
            var booking = bookingHistory[index];
            return Container(
              width: w,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 5),
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
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          height: 21.82 / 16.0,
                        ),
                      ),
                      SizedBox(width: w * 0.020),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0x4DA0F2A3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (booking.appointmentType == 0) ? "Online" : "Offline",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10.0,
                            color: Color(0xff0DC613),
                            fontWeight: FontWeight.w700,
                            height: 13.64 / 10.0,
                          ),
                        ),
                      ),
                      Spacer(),

                      InkResponse(
                        onTap: (){
                          downloadscript();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: Color(0x80A0F2F0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${booking.appointment}",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color(0xff088A87),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.calendar_month, size: 16),
                      SizedBox(width: 8),
                      Text(
                        "${booking.dateOfAppointment}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                          height: 18 / 12.0,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.access_time, size: 16),
                      SizedBox(width: 8),
                      Text(
                        "${booking.timeOfAppointment}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                          height: 18 / 12.0,
                        ),
                      ),
                    ],
                  ),
                  // Use Visibility widget to conditionally show widgets without taking up space
                  Visibility(
                    visible: booking.ratingStatus != 1,
                    child: Column(
                      children: [
                        Divider(thickness: 0.5),
                        InkResponse(
                          onTap: () async {
                            var res= await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductRating(
                                  app_id: booking.id,
                                  page_source: booking.pageSource,
                                ),
                              ),
                            );
                            if(res==true){
                              setState(() {
                                is_loading=true;
                                GetBookingHistory();
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              SizedBox(width: 5),
                              Text(
                                "Rate us",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
