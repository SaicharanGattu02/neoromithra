import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../BookAppointment.dart';
import '../CustomAppBar.dart';
import '../Model/ReviewListModel.dart';
import '../ReviewListScreen.dart';
import '../services/userapi.dart';
import '../utils/ReviewCard.dart';

class ArtTherapyScreen extends StatefulWidget {
  const ArtTherapyScreen({super.key});

  @override
  State<ArtTherapyScreen> createState() => _ArtTherapyScreenState();
}

class _ArtTherapyScreenState extends State<ArtTherapyScreen> {
  bool showFocus = true;
  bool showBenefits = false;

  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }
  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist("Art Therapy");
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
        title: 'Art Therapy',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: h *
                    0.15), // Add padding to avoid overlap with fixed buttons
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  height: h * 0.3,
                  child: Image.asset(
                      'assets/ArtTherapy.png',
                      fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Art Therapy is a form of expressive therapy that uses artistic activities, such as drawing, painting, and sculpting, to help individuals communicate and process their emotions. Unlike traditional talk therapy, art therapy allows for self-expression through visual means, making it an effective tool for those who may find verbal communication challenging.",
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
                        _buildTextWithCircle('Emotional Expression',
                            'Provides a safe and non-verbal way for individuals to express complex emotions and experiences.'),
                        SizedBox(height: 10),
                        _buildTextWithCircle('Self-Discovery',
                            'Encourages self-exploration and insight through creative processes, helping individuals understand their thoughts and feelings.'),
                        SizedBox(height: 10),
                        _buildTextWithCircle('Stress Relief',
                            'Acts as a therapeutic outlet for reducing stress and promoting relaxation.'),
                        SizedBox(height: 10),
                        _buildTextWithCircle('Enhanced Communication',
                            'Improves communication skills by enabling individuals to articulate their emotions and experiences through art.'),
                        SizedBox(height: 10),
                        _buildTextWithCircle('Coping Skills',
                            'Develops effective coping mechanisms and problem-solving strategies through artistic expression.'),
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
                        Text("- Good for Health"),
                        // Add more benefits here as needed
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

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bookappointment(pagesource: "Art Therapy",)));
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewListScreen(pageSource: "Art Therapy",)));
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

  Widget _buildTextWithCircle(String boldText, String normalText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   width: 10.0,
        //   height: 10.0,
        //   decoration: BoxDecoration(
        //     color: Colors.black,
        //     shape: BoxShape.circle,
        //   ),
        // ),
        SizedBox(width: 8.0), // Space between circle and text
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$boldText: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.black),
                ),
                TextSpan(
                  text: normalText,
                  style:
                      TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
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
