import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:provider/provider.dart';

import '../Components/Shimmers.dart';
import '../Providers/BookingHistoryProviders.dart';
import '../utils/Color_Constants.dart';
import 'CustomAppBar.dart';
import '../Model/BehaviouralTrackingModel.dart';

class BehavioralTrackingReport extends StatefulWidget {
  final String id;
  const BehavioralTrackingReport({Key? key, required this.id})
      : super(key: key);
  @override
  _BehavioralTrackingReportState createState() =>
      _BehavioralTrackingReportState();
}

class _BehavioralTrackingReportState extends State<BehavioralTrackingReport> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingHistoryProvider>(context, listen: false)
          .getSessionFeedback(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Behavioral Tracking Report',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "general_sans",
              color: primarycolor,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: primarycolor),
            onPressed: () => context.pop(),
          ),
        ),
        body: Consumer<BookingHistoryProvider>(
          builder: (context, provider, child) {
            final details = provider.sessionFeedback;
            if (provider.isLoading) {
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
            if (details.isEmpty) {
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
                        "No Behavioural report found!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "general_sans",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: details.map((report) {
                  return Card(
                    elevation: 4, // Subtle shadow for depth
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Therapist Name
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 20,
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontFamily: "general_sans",
                                        ),
                                    children: [
                                      const TextSpan(
                                        text: 'Therapist: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: report.staffId?.toString() ?? "-",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Date
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range_outlined,
                                size: 18,
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                report.createdAt ?? "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "general_sans",
                                      color: Colors.black54,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Behavioral Report
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontFamily: "general_sans",
                                  ),
                              children: [
                                const TextSpan(
                                  text: "Behavioral Report : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: report.text ?? "-",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
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
        ],
      ),
    );
  }
}
