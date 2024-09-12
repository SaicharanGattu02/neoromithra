import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BookAppointment.dart';
import '../CustomAppBar.dart';

class GroupCounsellingScreen extends StatefulWidget {
  const GroupCounsellingScreen({super.key});

  @override
  State<GroupCounsellingScreen> createState() => _GroupCounsellingScreenState();
}

class _GroupCounsellingScreenState extends State<GroupCounsellingScreen> {
  bool showFocus = true;
  bool showBenefits = false;


  Future<void> _launchCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Group Counseling',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: h * 0.1), // Add padding to avoid overlap with fixed buttons
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  height: h * 0.3,
                  child: Image.asset(
                    "assets/GroupCounseling.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Group Counseling Services at NeuroMitra",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "At NeuroMitra, we believe in the power of shared experiences. Our Group Counseling Services provide a supportive and collaborative environment where individuals can come together to explore common challenges, share insights, and find strength in community.",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
                  child: Column(
                    children: [
                      Text(
                        "What is Group Counseling?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Group Counseling involves bringing together a small group of individuals who share similar concerns or life experiences. Led by a skilled therapist, these sessions offer a space for participants to discuss their feelings, learn from each other, and develop new coping strategies. Whether you’re dealing with stress, anxiety, grief, or other life challenges, group counseling can offer the support and perspective you need.",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showFocus = true;
                            // showBenefits = false;
                          });
                        },
                        child: Text(
                          "Benefits of Group Counseling",
                          style: TextStyle(
                            color: showFocus
                                ? Color(0xFF0094FF): Color(0xFF303030),
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            decoration:
                            showFocus
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            decorationColor: showFocus
                                ? Color(0xFF0094FF): Color(0xFF303030),
                          ),
                        ),
                      ),
                      // SizedBox(width: 30),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       showBenefits = true;
                      //       showFocus = false;
                      //     });
                      //   },
                      //   child: Text(
                      //     "Benefits",
                      //     style: TextStyle(
                      //       color: Color(0xFF303030),
                      //       fontSize: 20,
                      //       fontFamily: "Inter",
                      //       fontWeight: FontWeight.w500,
                      //       decoration: showBenefits
                      //           ? TextDecoration.underline
                      //           : TextDecoration.none,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: showFocus,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextWithCircle(
                          'Shared Understanding',
                          ' Connect with others who are facing similar challenges, fostering a sense of belonging and mutual support.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Multiple Perspectives',
                          'Gain insights from the diverse experiences and viewpoints of group members, helping you see your situation in a new light.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Skill Development',
                          'Learn practical coping strategies, communication skills, and problem-solving techniques in a supportive setting.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Enhanced Motivation',
                          'Being part of a group can provide encouragement and accountability, helping you stay committed to your personal growth.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Cost-Effective',
                          'Group counseling is often more affordable than individual sessions, making it a great option for those seeking quality care at a lower cost.',
                        ),
                      ],
                    ),
                  ),
                ),
                // Visibility(
                //   visible: showBenefits,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SizedBox(height: 10),
                //         Text("Our Crisis Counseling Services are available to individuals, families, and groups facing a wide range of crisis situations, including but not limited to:",
                //           style: TextStyle(
                //             fontWeight: FontWeight.normal,
                //             fontSize: 16.0,
                //             color: Colors.black,
                //           ),),
                //         SizedBox(height: 15),
                //         _buildTextWithCircle('Personal Crises',
                //           'Relationship issues, sudden loss, or personal trauma.',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle('Community Crises',
                //           ' Natural disasters, accidents, or community-wide emergencies.',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle('Health Crises',
                //           'Serious illness diagnosis or medical emergencies.',
                //         ),
                //
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    _launchCall("8885320115");
                  },
                  child: Container(
                    height: h * 0.06,
                    width: w*0.4,
                    color: Color(0xFF0094FF),
                    child: Center(
                      child: Text(
                        "Call Us",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  InkWell(onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookappointment(pagesource: "Group Counselling",)));
                  },
                    child: Container(
                      height: h * 0.06,
                      color: Color(0xFF0833A0),
                      child: Center(
                        child: Text(
                          "Book Appointment",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithCircle(String? boldText, String normalText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.only(top: 6.0), // Aligns the dot with the first line of text
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8.0), // Space between circle and text
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                if (boldText != null)
                  TextSpan(
                    text: '$boldText: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                TextSpan(
                  text: normalText,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
