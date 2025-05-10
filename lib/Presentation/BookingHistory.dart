import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/Presentation/AddRating.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Components/Shimmers.dart';
import '../Providers/BookingHistoryProviders.dart';
import '../utils/Color_Constants.dart';
import 'BehavioralTrackingReport.dart';
import 'CustomAppBar.dart';
import '../Model/BookingHistoryModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  void initState() {
    Provider.of<BookingHistoryProviders>(context, listen: false)
        .GetBookingHistory();
    super.initState();
  }

  Future<void> downloadInvoice(String url) async {
    try {
      debugPrint("Checking storage permission...");
      var status = await Permission.mediaLibrary.status;

      if (!status.isGranted) {
        debugPrint("Storage permission not granted. Requesting...");
        await Permission.mediaLibrary.request();
      }
      status = await Permission.mediaLibrary.status;
      if (status.isGranted) {
        debugPrint("Storage permission granted.");
        Directory dir =
            Directory('/storage/emulated/0/Download/'); // for Android
        if (!await dir.exists()) {
          debugPrint(
              "Download directory does not exist. Using external storage directory.");
          dir = await getExternalStorageDirectory() ?? Directory.systemTemp;
        } else {
          debugPrint("Download directory exists: ${dir.path}");
        }

        String generateFileName(String originalName) {
          // Extract file extension
          String extension = originalName.split('.').last;
          // Generate unique identifier
          String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
          // Return unique filename with the same extension
          String fileName = "Prescription_$uniqueId.$extension";
          debugPrint("Generated filename: $fileName");
          return fileName;
        }

        // Start downloading the file
        debugPrint("Starting download from: $url");
        FileDownloader.downloadFile(
          url: url.toString().trim(),
          name: generateFileName("Order_invoice.docx"), // Adjusted here
          notificationType: NotificationType.all,
          downloadDestination: DownloadDestinations.publicDownloads,
          onDownloadRequestIdReceived: (downloadId) {
            debugPrint('Download request ID received: $downloadId');
          },
          onProgress: (fileName, progress) {
            debugPrint('Downloading $fileName: $progress%');
          },
          onDownloadError: (String error) {
            debugPrint('DOWNLOAD ERROR: $error');
          },
          onDownloadCompleted: (path) {
            debugPrint('Download completed! File saved at: $path');
            setState(() {
              // Update UI if necessary
            });
          },
        );
      } else {
        debugPrint("Storage permission denied.");
      }
    } catch (e, s) {
      debugPrint('Exception caught: $e');
      debugPrint('Stack trace: $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Booking History',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "general_sans",
                  color: primarycolor,
                  fontSize: 18)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton.filled(
            icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              backgroundColor: Color(0xFFECFAFA), // Filled color
            ),
          ),
        ),
        body: Consumer<BookingHistoryProviders>(
          builder: (context, bookingHistoryProvider, child) {
            if (bookingHistoryProvider.isLoading) {
              // 🟦 Shimmer loading skeleton
              return ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (_, __) => bookingHistoryShimmerCard(context),
              );
            }
            if (bookingHistoryProvider.bookingHistory.isEmpty) {
              // 📭 Empty state with visual
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/no_booking_history.png",
                          width: 220, height: 220),
                      SizedBox(height: 20),
                      Text(
                        "No Booking History Found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "general_sans",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Looks like you haven’t booked any appointments yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "general_sans",
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // ✅ Booking history UI
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.separated(
                itemCount: bookingHistoryProvider.bookingHistory.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (BuildContext context, int index) {
                  final booking = bookingHistoryProvider.bookingHistory[index];
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0x4DA0F2F0),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Header: ID + Type + Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order No-${booking.id}",
                              style: TextStyle(
                                fontFamily: "general_sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0x4DA0F2A3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                booking.appointmentType == 0
                                    ? "Online"
                                    : "Offline",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff0DC613),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "general_sans",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: Color(0x80A0F2F0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${booking.appointment}",
                                style: TextStyle(
                                  fontFamily: "general_sans",
                                  fontSize: 14,
                                  color: Color(0xff088A87),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // 🔹 Name and Source
                        Text(
                          booking.fullName??"",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff088A87),
                            fontFamily: "general_sans",
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          booking.pageSource??"",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "general_sans",
                          ),
                        ),
                        SizedBox(height: 10),
                        // 🔹 Date & Time
                        Row(
                          children: [
                            Icon(Icons.calendar_month, size: 16),
                            SizedBox(width: 6),
                            Text(
                              booking.dateOfAppointment??"",
                              style: TextStyle(
                                fontFamily: "general_sans",
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.access_time, size: 16),
                            SizedBox(width: 6),
                            Text(
                              booking.timeOfAppointment??"",
                              style: TextStyle(
                                fontFamily: "general_sans",
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // 🔹 Prescription download
                        if (booking.filePath != null) ...[
                          InkWell(
                            onTap: () {
                              downloadInvoice(
                                  "https://admin.neuromitra.com/api/downloadfile/${booking.id}");
                            },
                            child: Row(
                              children: [
                                Icon(Icons.download_outlined,
                                    color: Color(0xff088A87)),
                                SizedBox(width: 5),
                                Text(
                                  "Download Prescription",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "general_sans",
                                    fontSize: 15,
                                    color: Color(0xff088A87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                        Divider(),
                        // 🔹 Actions: Track & Rate
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // View behaviour track
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.list_alt_outlined,
                                      color: Color(0xff088A87)),
                                  SizedBox(width: 5),
                                  Text(
                                    "View Behavioural Track",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "general_sans",
                                      fontSize: 15,
                                      color: Color(0xff088A87),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (booking.ratingStatus != 1 &&
                                booking.filePath != null)
                              InkWell(
                                onTap: () async {
                                  // Handle rating logic
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow[700]),
                                    SizedBox(width: 5),
                                    Text(
                                      "Rate us",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "general_sans",
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
            );
          },
        ));
  }

  Widget bookingHistoryShimmerCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🟦 Top row (Order No - Type - Appointment)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerText(100, 16, context),
              shimmerText(60, 16, context),
              shimmerText(80, 16, context),
            ],
          ),
          SizedBox(height: 10),

          // 🟦 Name
          shimmerText(140, 14, context),
          SizedBox(height: 6),

          // 🟦 Page Source
          shimmerText(100, 14, context),
          SizedBox(height: 10),

          // 🟦 Date and Time row
          Row(
            children: [
              shimmerText(100, 12, context),
              Spacer(),
              shimmerText(80, 12, context),
            ],
          ),
          SizedBox(height: 14),

          // 🟦 Download prescription row
          shimmerText(160, 14, context),
          SizedBox(height: 12),

          // 🟦 Divider mimic
          shimmerDivider(1, double.infinity, context),
          SizedBox(height: 12),

          // 🟦 Bottom row (Behavioral track - Rate us)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerText(160, 14, context),
              shimmerText(80, 14, context),
            ],
          ),
        ],
      ),
    );
  }

}
