import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../Components/Shimmers.dart';
import '../Providers/BookingHistoryProviders.dart';
import '../utils/Color_Constants.dart';
import 'package:path_provider/path_provider.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingHistoryProvider>(context, listen: false).getBookingHistory();
    });
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
        body: Consumer<BookingHistoryProvider>(
          builder: (context, bookingHistoryProvider, child) {
            if (bookingHistoryProvider.isLoading) {
              // 🟦 Shimmer loading skeleton
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, __) => bookingHistoryShimmerCard(context),
                      childCount: 3,
                    ),
                  ),
                ],
              );
            }

            if (bookingHistoryProvider.appointments.isEmpty) {
              // 📭 Empty state
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
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
                    ),
                  ),
                ],
              );
            }

            // ✅ Booking history UI
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
                  if (bookingHistoryProvider.hasMore &&
                      !bookingHistoryProvider.isLoading) {
                    bookingHistoryProvider.loadMoreBookingHistory();
                  }
                }
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.all(15),
                    sliver: SliverList.separated(
                      itemCount: bookingHistoryProvider.appointments.length,
                      itemBuilder: (context, index) {
                        final booking =
                            bookingHistoryProvider.appointments[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        booking.appointmentMode ?? "",
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
                                        "${booking.appointmentFor}",
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
                                Text(
                                  booking.serviceName ?? "",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff088A87),
                                    fontFamily: "general_sans",
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Week Day's : ${booking.calenderDays ?? ""}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "general_sans",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "₹${booking.amount.toString()}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "general_sans",
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.calendar_month_outlined,
                                        size: 16),
                                    SizedBox(width: 6),
                                    Text(
                                      booking.appointmentRequestDate ?? "",
                                      style: TextStyle(
                                        fontFamily: "general_sans",
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                    color: Colors.grey.shade300, thickness: 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        context.push("/sessions?id=${booking.id}");
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Color(0xff088A87),
                                      ),
                                      label: Text(
                                        "View Sessions",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "general_sans",
                                          fontSize: 15,
                                          color: Color(0xff088A87),
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(0, 0),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 12),
                    ),
                  ),
                  if (bookingHistoryProvider.hasMore)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 1,
                        )),
                      ),
                    ),
                ],
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
