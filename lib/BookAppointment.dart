import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/AddRating.dart';
import 'package:neuromithra/services/userapi.dart';
import 'Bookappointment1.dart';
import 'CustomAppBar.dart';
import 'Model/PreviousBookingModel.dart';


class Bookappointment extends StatefulWidget {
  final String pagesource;
  const Bookappointment({super.key, required this.pagesource});

  @override
  State<Bookappointment> createState() => _BookappointmentState();
}

class _BookappointmentState extends State<Bookappointment> {
  bool is_loading=true;
  @override
  void initState() {
    GetPreviousBookingHistory();
    super.initState();
  }
  List<Patients> patients=[];
  Future<void> GetPreviousBookingHistory() async {
    final Response = await Userapi.getpreviousbookings(widget.pagesource);
    if (Response != null) {
      setState(() {
        if(Response.status==true){
          patients=Response.patients??[];
          is_loading=false;
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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Previous Booking History',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body:(is_loading)? Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ):
      (patients.length==0)?
      InkResponse(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Bookappointment1(pagesource: widget.pagesource,patientID: "",patient_name: "",p_age: "",),
            ),
          );
        },
        child: Center(
          child: Container(
            width: 150.0,
            height: 150.0,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0x4DA0F2F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 24.0,
                ),
                SizedBox(height: 4.0),
                Text(
                  "Add New Appointment",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      )

      // Center(
      //   child: Lottie.asset(
      //     'assets/animations/nodata1.json',
      //     height: 360,
      //     width: 360,
      //   ),
      // )
          :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: patients.isEmpty ? 1 : patients.length + 1, // Ensure at least one item
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bookappointment1(pagesource: widget.pagesource,patientID: "",patient_name: "",p_age: "",),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    width: 200.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Color(0x4DA0F2F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Add New Appointment",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Safely access the booking history
              var booking = patients[index - 1]; // Adjust index for bookingHistory
              return InkResponse(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bookappointment1(pagesource: widget.pagesource, patientID: booking.pid.toString(),patient_name:booking.pname??"",p_age: booking.page.toString()??"",),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0x4DA0F2F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Patient ID-${booking.pid}",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          height: 21.82 / 16.0,
                        ),
                      ),
                      SizedBox(width: w * 0.020),
                      Text(
                        booking.pname ?? "",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          height: 13.64 / 10.0,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Color(0x80A0F2F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Age: ${booking.page}",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xff088A87),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      )
    );
  }
}
