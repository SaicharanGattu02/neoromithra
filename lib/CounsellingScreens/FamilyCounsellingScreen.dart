import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BookAppointment.dart';
import '../CustomAppBar.dart';
import '../Model/ReviewListModel.dart';
import '../ReviewListScreen.dart';
import '../services/userapi.dart';
import '../utils/ReviewCard.dart';

class FamilyCounsellingScreen extends StatefulWidget {
  const FamilyCounsellingScreen({super.key});

  @override
  State<FamilyCounsellingScreen> createState() => _FamilyCounsellingScreenState();
}

class _FamilyCounsellingScreenState extends State<FamilyCounsellingScreen> {
  bool showFocus = true;
  bool showBenefits = false;
  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }

  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist("Family Counselling");
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
        title: 'Family Counseling',
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
                    "assets/Counciling/family_counsiling.jpeg",
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
                        "Family Counseling",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Family Counseling at NEUROMITRA is designed to help families navigate challenges, improve communication, and build stronger, healthier relationships. Whether you’re dealing with conflicts, life transitions, or simply want to enhance your family dynamic, our experienced counselors are here to guide you through the process.",
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
                        "What is Family Counseling?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Family counseling is a form of therapy that addresses the behaviors, emotions, and interactions within a family system. It focuses on improving communication, resolving conflicts, and fostering a supportive environment where each family member feels valued and understood. Family counseling can be especially beneficial during times of stress, such as divorce, illness, or major life changes.",
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
                          'Improved Communication',
                          'Helps family members express their thoughts and feelings more effectively, leading to better understanding and cooperation.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Conflict Resolution',
                          'Provides tools and strategies to resolve conflicts in a healthy and constructive manner.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Strengthened Relationships',
                          'Enhances emotional bonds between family members, promoting unity and togetherness.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Coping with Life Transitions',
                          'Assists families in navigating significant life changes, such as moving, loss of a loved one, or changes in family structure.',
                        ), SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Support for Parenting Challenges',
                          'Offers guidance on parenting issues, helping parents and children work together more harmoniously.',
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
                        Text("Family counseling is beneficial for:",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),),
                        SizedBox(height: 15),
                        _buildTextWithCircle(null,
                          'Families experiencing ongoing conflicts or communication breakdowns',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(null,
                          'Parents and children struggling with discipline issues or differing expectations',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(null,
                          'Families undergoing major life transitions, such as divorce, remarriage, or relocation',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(null,
                            'Families dealing with the impact of mental health issues, addiction, or trauma',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(null,
                          'Anyone looking to strengthen their family relationships and create a more positive home environment',
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

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookappointment(pagesource: "Family Counselling",)));
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewListScreen(pageSource: "Family Counselling",)));
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
