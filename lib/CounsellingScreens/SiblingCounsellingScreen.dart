import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BookAppointment.dart';
import '../CustomAppBar.dart';
import '../Model/ReviewListModel.dart';
import '../ReviewListScreen.dart';
import '../services/userapi.dart';
import '../utils/ReviewCard.dart';

class SiblingCounsellingScreen extends StatefulWidget {
  const SiblingCounsellingScreen({super.key});

  @override
  State<SiblingCounsellingScreen> createState() => _SiblingCounsellingScreenState();
}

class _SiblingCounsellingScreenState extends State<SiblingCounsellingScreen> {
  bool showFocus = true;
  bool showBenefits = false;
  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }

  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist("Sibling Counselling");
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
        title: 'Sibling Counseling',
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
                    "assets/sibiling_counciling.jpeg",
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
                        "Sibling Counseling",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Sibling Counseling at NEUROMITRA is designed to support siblings of children with special needs, helping them navigate the unique challenges they may face. Our goal is to foster understanding, communication, and emotional resilience within the sibling relationship, ensuring a supportive and harmonious family dynamic.",
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
                        "What is Sibling Counseling?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Sibling Counseling focuses on addressing the emotional and psychological needs of siblings who may experience feelings of jealousy, resentment, confusion, or guilt due to their brother or sister’s special needs. This type of counseling provides a safe space for siblings to express their feelings, gain a deeper understanding of their sibling’s condition, and develop coping strategies to manage their emotions and responsibilities.",
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
                          'Understanding and Acceptance',
                          'Helps siblings develop a better understanding of their brother or sister’s special needs, fostering empathy and acceptance.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Emotional Support',
                          'Provides a space for siblings to share their feelings and receive validation and support.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Coping Strategies',
                          ' Equips siblings with tools and techniques to manage their emotions and cope with the challenges of growing up with a sibling who has special needs.',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Improved Communication',
                          'Enhances communication skills within the family, helping siblings express their needs and concerns more effectively.',
                        ), SizedBox(height: 10),
                        _buildTextWithCircle(
                          'Strengthened Sibling Bonds',
                          'Promotes positive interactions and strengthens the emotional bond between siblings, contributing to a more supportive family',
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
                        Text("Sibling Counseling is beneficial for:",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),),
                        SizedBox(height: 15),
                        _buildTextWithCircle(null,
                          'Siblings of children with special needs who may be struggling with feelings of jealousy, resentment, or guilt',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(null,
                          'Families looking to improve communication and strengthen relationships among siblings',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(null,
                          'Siblings who need support in understanding and accepting their brother or sister’s condition',
                        ),
                        SizedBox(height: 10),
                        _buildTextWithCircle(null,
                          'Parents who want to ensure a balanced and supportive environment for all their children',
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

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookappointment(pagesource: "Sibling Counselling",)));
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewListScreen(pageSource: "Sibling Counselling",)));
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
