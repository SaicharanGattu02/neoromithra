import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/services/userapi.dart';

import 'CustomAppBar.dart';
import 'Model/BehaviouralTrackingModel.dart';

class BehavioralTrackingReport extends StatefulWidget {
  final int id;
  final String page_source;
  const BehavioralTrackingReport({Key? key, required this.id,required this.page_source})
      : super(key: key);

  @override
  _BehavioralTrackingReportState createState() =>
      _BehavioralTrackingReportState();
}

class _BehavioralTrackingReportState extends State<BehavioralTrackingReport> {
  @override
  void initState() {
    GetBehaviouraltrackingreport();
    super.initState();
  }
  bool is_loading = true;
  List<Details> details = [];
  Future<void> GetBehaviouraltrackingreport() async {
    final Response = await Userapi.getbehaviourallist(widget.id.toString(),widget.page_source);
    if (Response != null) {
      setState(() {
        if (Response.status == true) {
          details = Response.details ?? [];
          is_loading = false;
        } else {
          is_loading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Behavioral Tracking Report',
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
        ),
        body: (is_loading)?Center(
          child: CircularProgressIndicator(),
        )
        :SingleChildScrollView(
          child: details.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                    Lottie.asset(
                      'assets/animations/nodata1.json',
                      height: 360,
                      width: 360,
                    ),
                  ],
                )
              : Column(
                  children: details.map((report) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16), // Adjust outer margin
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(
                            12.0), // Match the outer container
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0x4DA0F2F0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Name: ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: report.pname,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.date_range_outlined, size: 18),
                                  SizedBox(width: 5),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Date: ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: report.dataDetails,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Track Details: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "${report.details}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(), // Use toList() to convert Iterable to List
                ),
        ));
  }
}
