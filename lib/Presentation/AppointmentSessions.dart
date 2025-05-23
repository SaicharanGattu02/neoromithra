import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/Shimmers.dart';
import '../Providers/BookingHistoryProviders.dart';
import '../utils/Color_Constants.dart';

class Appointmentsessions extends StatefulWidget {
  final String id;
  const Appointmentsessions({super.key, required this.id});

  @override
  State<Appointmentsessions> createState() => _AppointmentsessionsState();
}

class _AppointmentsessionsState extends State<Appointmentsessions> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingHistoryProvider>(context, listen: false)
          .getSessionsByID(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Appoitment Sessions',
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

            if (bookingHistoryProvider.sessions.isEmpty) {
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
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(15),
                  sliver: SliverList.separated(
                    itemCount: bookingHistoryProvider.sessions.length,
                    itemBuilder: (context, index) {
                      final booking = bookingHistoryProvider.sessions[index];
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
                                    "Slot ID-${booking.slotId}",
                                    style: TextStyle(
                                      fontFamily: "general_sans",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.calendar_month_outlined, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    booking.date ?? "",
                                    style: TextStyle(
                                      fontFamily: "general_sans",
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Assigned Therapist : ${booking.staff?.name ?? ""}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff088A87),
                                  fontFamily: "general_sans",
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "general_sans",
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff088A87),
                                      ),
                                      children: [
                                        TextSpan(text: "Start Time: "),
                                        TextSpan(
                                          text: booking.startTime ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "general_sans",
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff088A87),
                                      ),
                                      children: [
                                        TextSpan(text: "End Time: "),
                                        TextSpan(
                                          text: booking.endTime ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              if (booking.meetUrl != "N/A") ...[
                                InkWell(
                                  onTap: () async {
                                    final url = Uri.parse(booking.meetUrl ?? "");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Cannot launch ${booking.meetUrl}')),
                                      );
                                    }
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "general_sans",
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff088A87),
                                      ),
                                      children: [
                                        TextSpan(text: "Meet URL: "),
                                        TextSpan(
                                          text: booking.meetUrl ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              Divider(
                                  color: Colors.grey.shade300, thickness: 1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      context.push(
                                          "/feedback_report?id=${booking.slotId}");
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Color(0xff088A87),
                                    ),
                                    label: Text(
                                      "View Report",
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "general_sans",
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff088A87),
                                      ),
                                      children: [
                                        TextSpan(text: "Status: "),
                                        TextSpan(
                                          text: booking.computedStatus ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
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
              ],
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
