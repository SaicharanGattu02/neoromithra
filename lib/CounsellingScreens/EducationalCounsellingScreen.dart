import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Presentation/BookAppointment.dart';
import '../Presentation/CustomAppBar.dart';
import '../Model/ReviewListModel.dart';
import '../Presentation/ReviewListScreen.dart';
import '../services/userapi.dart';
import '../utils/ReviewCard.dart';

class EducationalCounsellingScreen extends StatefulWidget {
  const EducationalCounsellingScreen({super.key});

  @override
  State<EducationalCounsellingScreen> createState() => _EducationalCounsellingScreenState();
}

class _EducationalCounsellingScreenState extends State<EducationalCounsellingScreen> {
  bool showFocus = true;
  bool showBenefits = false;

  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }

  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist("Educational Counselling");
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
        title: 'Educational Counseling',
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
                    "assets/Counciling/educationol_counsiling.jpeg",
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
                        "Educational Counseling",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Educational Counseling provides personalized guidance to support children and parents in navigating academic challenges and achieving educational success. This service focuses on identifying learning difficulties, creating effective study plans, and assisting with school transitions, ensuring that each child receives the tools and strategies needed to thrive academically. Whether addressing specific learning disabilities or helping with academic planning, Educational Counseling empowers students to reach their full potential and supports parents in understanding and meeting their child’s educational needs.",
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
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           setState(() {
                //             showFocus = true;
                //             showBenefits = false;
                //           });
                //         },
                //         child: Text(
                //           "Key Areas of Focus",
                //           style: TextStyle(
                //             color: Color(0xFF303030),
                //             fontSize: 20,
                //             fontFamily: "Inter",
                //             fontWeight: FontWeight.w500,
                //             decoration: showFocus
                //                 ? TextDecoration.underline
                //                 : TextDecoration.none,
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: 30),
                //       InkWell(
                //         onTap: () {
                //           setState(() {
                //             showBenefits = true;
                //             showFocus = false;
                //           });
                //         },
                //         child: Text(
                //           "Benefits",
                //           style: TextStyle(
                //             color: Color(0xFF303030),
                //             fontSize: 20,
                //             fontFamily: "Inter",
                //             fontWeight: FontWeight.w500,
                //             decoration: showBenefits
                //                 ? TextDecoration.underline
                //                 : TextDecoration.none,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 20),
                // Visibility(
                //   visible: showFocus,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         _buildTextWithCircle(
                //           'Emotional Expression',
                //           'Provides children with a safe space to express their thoughts and feelings openly.',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle(
                //           'Anxiety and Depression Management',
                //           'Helps children understand and manage symptoms of anxiety, depression, and other mood disorders.',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle(
                //           'Behavioral Support',
                //           'Addresses behavioral challenges by teaching positive behavior strategies and self-control techniques.',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle(
                //           'Self-Esteem Building',
                //           'Promotes healthy self-esteem and confidence in children.',
                //         ), SizedBox(height: 10),
                //         _buildTextWithCircle(
                //           'Coping Skills Development',
                //           'Equips children with practical coping mechanisms to handle stress, peer pressure, and other challenges.',
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Visibility(
                //   visible: showBenefits,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SizedBox(height: 10),
                //         Text("Individual counseling for children is beneficial for:",
                //           style: TextStyle(
                //             fontWeight: FontWeight.normal,
                //             fontSize: 16.0,
                //             color: Colors.black,
                //           ),),
                //         SizedBox(height: 15),
                //         _buildTextWithCircle(null,
                //           'Children experiencing anxiety, depression, or other mental health issues',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle(null,
                //           'Those struggling with behavioral problems, such as aggression, defiance, or hyperactivity',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle(null,
                //           'Children facing significant life changes, such as parental divorce, relocation, or the loss of a loved one',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle(null,
                //           'Kids who have difficulty making friends or dealing with peer pressure',
                //         ),
                //         SizedBox(height: 10),
                //         _buildTextWithCircle(null,
                //           'Children with low self-esteem or who are experiencing bullying',
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookappointment(pagesource: "Educational Counselling",)));
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewListScreen(pageSource: "Educational Counselling",)));
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
