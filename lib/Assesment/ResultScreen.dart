import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/CustomAppButton.dart';
import '../Presentation/MainDashBoard.dart';
import '../utils/Color_Constants.dart';

class Resultscreen extends StatefulWidget {
  const Resultscreen({Key? key}) : super(key: key);

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  int viewIndex=0;
  Future<void> _launchCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            color: primarycolor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () =>  context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(viewIndex==0)...[
              Center(
                child: Lottie.asset(
                  'assets/animations/done.json',
                  height: 250,
                  width: 250,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Thank you! Your responses have been sent to the therapist. They will review them and contact you to schedule your session.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              // CustomAppButton(
              //   text: 'View Score',
              //   onPlusTap: () {
              //     setState(() {
              //       viewIndex=1;
              //     });
              //   },
              // ),
            ]else...[
              Text(
                "Scoring and Reflection:",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,fontFamily: "Poppins",height: 1),
              ),
              SizedBox(height: 10),
              Text("Total your scores for each section.",style: TextStyle(
                  fontFamily: "Poppins",
                fontSize: 15
              ),),
              SizedBox(height: 10),
              // SizedBox(
              //   height: 400,
              //   child: ListView(
              //     children: widget.resultData.entries.map((entry) {
              //       return Card(
              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              //         elevation: 1,
              //         margin: EdgeInsets.symmetric(vertical: 8,horizontal: 3),
              //         child: ListTile(
              //           leading: CircleAvatar(
              //             backgroundColor: Colors.blueAccent,
              //             child: Icon(Icons.check, color: Colors.white),
              //           ),
              //           title: Text(
              //             entry.key,
              //             style: TextStyle(fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w500),
              //           ),
              //           trailing: Container(
              //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //             decoration: BoxDecoration(
              //               color: Colors.blueAccent,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Text(
              //               entry.value.toString(),
              //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              //             ),
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
              SizedBox(height: 20),
              Text("Interpretation:",style: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600
              ),),
              // if(widget.role=="1")...[
              //   SizedBox(
              //     height: 500, // Adjust based on your requirement
              //     child: ListView(
              //       shrinkWrap: true, // Ensures proper scrolling inside Column
              //       physics: NeverScrollableScrollPhysics(), // Prevents double scrolling issues
              //       children: [
              //         ScoreCard(
              //           scoreRange: "85-100",
              //           description:
              //           "Strong development and self-awareness. You’re generally satisfied with your growth.",
              //           color: Colors.green,
              //           icon: Icons.thumb_up,
              //         ),
              //         ScoreCard(
              //           scoreRange: "65-84",
              //           description:
              //           "Some room for improvement. You may be doing well but could focus on specific aspects.",
              //           color: Colors.blue,
              //           icon: Icons.trending_up,
              //         ),
              //         ScoreCard(
              //           scoreRange: "45-64",
              //           description:
              //           "Moderate development. Consider strengthening cognitive and emotional well-being.",
              //           color: Colors.orange,
              //           icon: Icons.warning,
              //         ),
              //         ScoreCard(
              //           scoreRange: "Below 45",
              //           description:
              //           "Significant areas need attention. Seek support or engage in personal growth activities.",
              //           color: Colors.red,
              //           icon: Icons.error,
              //         ),
              //       ],
              //     ),
              //   ),
              //   SizedBox(height: 20,),
              //   CustomAppButton(
              //     text: 'View our Counselling services',
              //     onPlusTap: () {
              //       context.push('/main_dashBoard?initialIndex=${2}');
              //     },
              //   ),
              //   SizedBox(height: 10),
              //   CustomAppButton(
              //     textcolor: Colors.white,
              //     text: 'Schedule A Session',
              //     color: Colors.green,
              //     onPlusTap: () {
              //       _launchCall("8885320115");
              //     },
              //   ),
              // ]else...[
              //   SizedBox(
              //     height: 450, // Adjust height as needed
              //     child: ListView(
              //       shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //       children: [
              //         ScoreCard(
              //           scoreRange: "41-50",
              //           description:
              //           "Development appears typical for age. No significant concerns.",
              //           color: Colors.green,
              //           icon: Icons.check_circle,
              //         ),
              //         ScoreCard(
              //           scoreRange: "31-40",
              //           description:
              //           "Some areas of concern. Consider monitoring and engaging in activities to boost skills.",
              //           color: Colors.blue,
              //           icon: Icons.info,
              //         ),
              //         ScoreCard(
              //           scoreRange: "21-30",
              //           description:
              //           "Potential developmental delays. A professional evaluation is recommended.",
              //           color: Colors.orange,
              //           icon: Icons.warning,
              //         ),
              //         ScoreCard(
              //           scoreRange: "0-20",
              //           description:
              //           "High likelihood of developmental concerns. Immediate professional consultation is advised.",
              //           color: Colors.red,
              //           icon: Icons.error,
              //         ),
              //       ],
              //     ),
              //   ),
              //   SizedBox(height: 20,),
              //   CustomAppButton(
              //     text: 'View our Therapy services',
              //     onPlusTap: () {
              //       context.push('/main_dashBoard?initialIndex=${1}');
              //     },
              //   ),
              //   SizedBox(height: 10),
              //   CustomAppButton(
              //     textcolor: Colors.white,
              //     text: 'Schedule A Session',
              //     color: Colors.green,
              //     onPlusTap: () {
              //       _launchCall("8885320115");
              //     },
              //   ),
              // ]
            ]

          ],
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final String scoreRange;
  final String description;
  final Color color;
  final IconData icon;

  ScoreCard({
    required this.scoreRange,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color.withOpacity(0.2),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(
          scoreRange,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color,fontFamily: "Poppins"),
        ),
        subtitle: Text(description, style: TextStyle(fontSize: 13,fontFamily: "Poppins")),
      ),
    );
  }
}
