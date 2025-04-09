import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/Presentation/AddRating.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:permission_handler/permission_handler.dart';

import 'BehavioralTrackingReport.dart';
import 'CustomAppBar.dart';
import '../Model/BookingHistoryModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class LastBooking extends StatefulWidget {
  const LastBooking({super.key});

  @override
  State<LastBooking> createState() => _LastBookingState();
}

class _LastBookingState extends State<LastBooking> {
  bool is_loading = true;
  @override
  void initState() {
    GetBookingHistory();
    super.initState();
  }

  Future<void> downloadInvoice(String url) async {
    try {
      print("Checking storage permission...");
      var status = await Permission.mediaLibrary.status;

      if (!status.isGranted) {
        print("Storage permission not granted. Requesting...");
        await Permission.mediaLibrary.request();
      }
      status = await Permission.mediaLibrary.status;
      if (status.isGranted) {
        print("Storage permission granted.");
        Directory dir =
        Directory('/storage/emulated/0/Download/'); // for Android
        if (!await dir.exists()) {
          print(
              "Download directory does not exist. Using external storage directory.");
          dir = await getExternalStorageDirectory() ?? Directory.systemTemp;
        } else {
          print("Download directory exists: ${dir.path}");
        }

        String generateFileName(String originalName) {
          // Extract file extension
          String extension = originalName.split('.').last;
          // Generate unique identifier
          String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
          // Return unique filename with the same extension
          String fileName = "Prescription_$uniqueId.$extension";
          print("Generated filename: $fileName");
          return fileName;
        }

        // Start downloading the file
        print("Starting download from: $url");
        FileDownloader.downloadFile(
          url: url.toString().trim(),
          name: generateFileName("Order_invoice.docx"), // Adjusted here
          notificationType: NotificationType.all,
          downloadDestination: DownloadDestinations.publicDownloads,
          onDownloadRequestIdReceived: (downloadId) {
            print('Download request ID received: $downloadId');
          },
          onProgress: (fileName, progress) {
            print('Downloading $fileName: $progress%');
          },
          onDownloadError: (String error) {
            print('DOWNLOAD ERROR: $error');
          },
          onDownloadCompleted: (path) {
            print('Download completed! File saved at: $path');
            setState(() {
              // Update UI if necessary
            });
          },
        );
      } else {
        print("Storage permission denied.");
      }
    } catch (e, s) {
      print('Exception caught: $e');
      print('Stack trace: $s');
    }
  }


  List<BookingHistory> bookingHistory = [];
  Future<void> GetBookingHistory() async {
    final Response = await Userapi.getBookingHistory();
    if (Response != null) {
      setState(() {
        if (Response.status == true) {
          is_loading = false;
          bookingHistory = Response.bookingHistory ?? [];
        } else {
          is_loading = false;
        }
      });
    }
  }

  // Future<void> downloadFile(String url) async {
  //   final sessionid = await PreferenceService().getString("token");
  //   final headers = {
  //     'Content-Disposition': 'attachment',
  //     'Authorization': 'Bearer $sessionid', // replace with your token
  //   };
  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //
  //     if (response.statusCode == 200) {
  //       // Get the directory to save the file
  //       final directory = await getApplicationDocumentsDirectory();
  //       final filePath =
  //           '${directory.path}/downloaded_file'; // specify your desired file name
  //
  //       // Write the response bytes to the file
  //       final file = File(filePath);
  //       await file.writeAsBytes(response.bodyBytes);
  //
  //       print('File downloaded to: $filePath');
  //     } else {
  //       print('Failed to download file: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

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
        title: Text( 'Booking History',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: Color(0xff3EA4D2),
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: Color(0xff3EA4D2)), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: (is_loading)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : (bookingHistory.length == 0)
              ? Center(
                  child: Lottie.asset(
                    'assets/animations/nodata1.json',
                    height: 360,
                    width: 360,
                  ),
                )
              : SingleChildScrollView(
                child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
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
                      crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
                          children: [
                            Text(
                              "Order No-${booking.id}",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
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
                                ),
                              ),
                            ),
                            Container(
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
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${booking.fullName}",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.0, color: Color(0xff088A87),
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        Text(
                          "${booking.pageSource}",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.calendar_month, size: 16),
                            SizedBox(width: 8),
                            Text(
                              "${booking.dateOfAppointment}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color: Color(0xff000000),
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
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        if (booking.filePath!=null) ...[
                          InkResponse(
                            onTap: () {
                              downloadInvoice("https://admin.neuromitra.com/api/downloadfile/${booking.id}");
                            },
                            child: Row(
                              children: [
                                Icon(Icons.download_outlined, color: Color(0xff088A87)),
                                SizedBox(width: 5),
                                Text(
                                  "Download Prescription",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                    fontSize: 15,
                                    color: Color(0xff088A87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        Divider(thickness: 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between actions
                          children: [
                            InkResponse(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BehavioralTrackingReport(id: booking.pid??0,page_source:booking.pageSource??"",),));
                                 // Navigator.push(context, MaterialPageRoute(builder: (context) => BehavioralTrackingReport(id: booking.id??0,page_source:booking.pageSource??"",),));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.list_alt_outlined, color: Color(0xff088A87)),
                                  SizedBox(width: 5),
                                  Text(
                                    "View Behavioural Track",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Inter",
                                      fontSize: 15,
                                      color: Color(0xff088A87),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (booking.ratingStatus != 1 && booking.filePath!=null) // Show only if not rated
                              InkResponse(
                                onTap: () async {
                                  var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddProductRating(
                                        app_id: booking.id,
                                        page_source: booking.pageSource,
                                      ),
                                    ),
                                  );
                                  if (res == true) {
                                    setState(() {
                                      is_loading = true;
                                      GetBookingHistory();
                                    });
                                  }
                                },
                                child: Row(
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
                      ],
                    ),
                  );
                },
                            ),
                          ),
                        ],
                      ),
              ),
    );
  }
}
