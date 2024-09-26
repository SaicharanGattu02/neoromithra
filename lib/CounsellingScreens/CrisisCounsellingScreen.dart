import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BookAppointment.dart';
import '../CustomAppBar.dart';
import '../Model/ReviewListModel.dart';
import '../ReviewListScreen.dart';
import '../services/userapi.dart';
import '../utils/ReviewCard.dart';

class CrisisCounsellingScreen extends StatefulWidget {
  const CrisisCounsellingScreen({super.key});

  @override
  State<CrisisCounsellingScreen> createState() => _CrisisCounsellingScreenState();
}

class _CrisisCounsellingScreenState extends State<CrisisCounsellingScreen> {
  bool showFocus = true;
  bool showBenefits = false;

  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }

  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist("Crisis Counseling");
    if (response != null) {
      setState(() {
        reviews=response.review??[];
      });
    }
  }
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
        title: 'Crisis Counseling',
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
                    "assets/CrisisCounseling.png",
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
                        "Crisis Counseling Services at NeuroMitra",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "At NeuroMitra, we understand that crises can strike unexpectedly, leaving individuals and families feeling overwhelmed and unsure of where to turn. Our Crisis Counseling Services are designed to provide immediate support and guidance during these challenging times.",
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
                        "What is Crisis Counseling?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Crisis Counseling involves short-term intervention aimed at helping individuals cope with acute stress and trauma resulting from a crisis situation. Whether you’re facing a personal crisis, dealing with a traumatic event, or experiencing heightened emotional distress, our counselors are here to provide compassionate support.",
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
                            showBenefits = false;
                          });
                        },
                        child: Text(
                          "Key Area Of Focus",
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            showBenefits = true;
                            showFocus = false;
                          });
                        },
                        child: Text(
                          "Benefits",
                          style: TextStyle(
                            color: showBenefits
                                ? Color(0xFF0094FF): Color(0xFF303030),
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            decoration: showBenefits
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            decorationColor: showBenefits
                                ? Color(0xFF0094FF): Color(0xFF303030),
                          ),
                        ),
                      ),
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
                          'Immediate Support',
                          'We offer timely and responsive counseling to address urgent emotional needs.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Holistic Care',
                          'Our counselors are trained in various therapeutic approaches, ensuring a comprehensive approach tailored to your unique situation.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Confidentiality',
                          'Your privacy is paramount. We provide a safe space for open and honest discussions without judgment.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Collaborative Guidance',
                          'We work collaboratively with you to develop coping strategies and navigate through difficult emotions.',
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: showBenefits,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text("Our Crisis Counseling Services are available to individuals, families, and groups facing a wide range of crisis situations, including but not limited to:",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),),
                        SizedBox(height: 15),
                        _buildTextWithCircle('Personal Crises',
                          'Relationship issues, sudden loss, or personal trauma.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle('Community Crises',
                          ' Natural disasters, accidents, or community-wide emergencies.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle('Health Crises',
                          'Serious illness diagnosis or medical emergencies.',
                        ),
                        
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if(reviews.length>0)...[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Customer Reviews',
                      style: TextStyle(
                          fontFamily: "Inter",
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  _buildReviewsList(),
                ],
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

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookappointment(pagesource: "Crisis Counseling",)));
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

  Widget _buildReviewsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: reviews.length > 3 ? 3 : reviews.length,
            physics: NeverScrollableScrollPhysics(), // Disable scrolling on this ListView
            shrinkWrap: true, // Allows the ListView to take the height of its children
            itemBuilder: (context, index) {
              return ReviewCard(
                customerName: reviews[index].userName??"",
                rating: reviews[index].rating??0,
                review: reviews[index].details??"",
              );
            },
          ),
          if (reviews.length > 3)
            InkResponse(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewListScreen(pageSource: "Crisis Counseling",)));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'More >>',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
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
