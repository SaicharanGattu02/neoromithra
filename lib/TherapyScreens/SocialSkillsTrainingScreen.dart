import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BookAppointment.dart';
import '../Customappbar.dart';

class SocialSkillsTrainingScreen extends StatefulWidget {
  const SocialSkillsTrainingScreen({super.key});

  @override
  State<SocialSkillsTrainingScreen> createState() => _SocialSkillsTrainingScreen();
}

class _SocialSkillsTrainingScreen extends State<SocialSkillsTrainingScreen> {
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
        title: 'Social Skills Training',
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
                    "assets/SocialSkills.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Social Skills Training involves a structured approach to teaching and practicing the behaviors and techniques necessary for effective social interaction. This training includes role-playing, real-life practice, and feedback to help individuals improve their ability to engage with others in positive and constructive ways.",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                    ),
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
                            showBenefits = false;
                          });
                        },

                        child: Text(
                  "Key Areas of Focus",
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
                      SizedBox(width: 30),
                      //   InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         showBenefits = true;
                      //         showFocus = false;
                      //       });
                      //     },
                      //     child: Text(
                      //       "Benefits",
                      //       style: TextStyle(
                      //         color: Color(0xFF303030),
                      //         fontSize: 20,
                      //         fontFamily: "Inter",
                      //         fontWeight: FontWeight.w500,
                      //         decoration: showBenefits
                      //             ? TextDecoration.underline
                      //             : TextDecoration.none,
                      //       ),
                      //     ),
                      //   ),
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
                          'Improved Communication',
                          'Enhances verbal and non-verbal communication skills to foster clearer and more effective interactions.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Enhanced Social Interaction',
                          'Helps individuals understand social cues and norms, leading to better interactions and relationships.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Conflict Resolution',
                          'Teaches strategies for managing and resolving conflicts in a constructive manner.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Increased Confidence',
                          'Builds self-esteem and confidence in social settings through practice and successful experiences.',
                        ), SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Better Relationship Building',
                          'Supports the development of friendships and professional relationships by improving interpersonal skills.',
                        ),
                      ],
                    ),
                  ),
                ),
                // Visibility(
                // visible: showBenefits,
                // child: Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       _buildTextWithCircle(null,
                //         'Are recovering from injuries or surgeries',
                //       ),
                //       SizedBox(height: 10),
                //       _buildTextWithCircle(null,
                //         'Experience chronic pain or discomfort',
                //       ),
                //       SizedBox(height: 10),
                //       _buildTextWithCircle(null,
                //         'Have difficulty with movement, strength, or balance',
                //       ),
                //       SizedBox(height: 10),
                //       _buildTextWithCircle(null,
                //         'Are dealing with musculoskeletal or neurological conditions',
                //       ),
                //       SizedBox(height: 10),
                //       _buildTextWithCircle(null,
                //         'Seek to improve overall physical health and functionality',
                //       ),
                //     ],
                //   ),
                // ),
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

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookappointment(pagesource: "Social Skills Training",)));
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