import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../BookAppointment.dart';
import '../CustomAppBar.dart';
import '../Model/ReviewListModel.dart';
import '../ReviewListScreen.dart';
import '../services/userapi.dart';
import '../utils/ReviewCard.dart';

class ABA_TherapyScreen extends StatefulWidget {
  const ABA_TherapyScreen({super.key});

  @override
  State<ABA_TherapyScreen> createState() => _ABA_TherapyScreenState();
}
class _ABA_TherapyScreenState extends State<ABA_TherapyScreen> {
  bool showFocus = true;
  bool showBenefits = false;

  // final List<Reviews> reviews = List.generate(
  //   7,
  //       (index) => Reviews(
  //     profileImage: 'https://example.com/profile.jpg', // Replace with a valid URL
  //     customerName: 'John Doe $index',
  //     rating: 4.5 - (index * 0.1), // Decreasing rating for demo
  //     review: 'This product is amazing! Highly recommend it. (Review $index) kjvh kjhfo iuhefuwefhwoeufh iuwfhewoeufhweuifhweifhwoeeufhweufhwfuiwhf kjhfuioefhwinvbiv',
  //   ),
  // );

  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }
  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist("ABA Therapy");
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
        title: 'Applied Behavior Analysis (ABA) Therapy',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: h * 0.1), // Add padding to avoid overlap with fixed buttons
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h * 0.3,
              child: Image.asset(
                "assets/(ABA)Therapy.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Applied Behavior Analysis (ABA) Therapy is a structured approach that applies principles of behavior science to address and improve targeted behaviors and skills.",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildTabButtons(),
            SizedBox(height: 20),
            _buildFocusOrBenefits(),
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
      bottomNavigationBar: _buildBottomBar(context, h, w),
    );
  }

  Widget _buildTabButtons() {
    return Container(
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
                color: showFocus ? Color(0xFF0094FF) : Color(0xFF303030),
                fontSize: 20,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                decoration: showFocus ? TextDecoration.underline : TextDecoration.none,
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
                color: showBenefits ? Color(0xFF0094FF) : Color(0xFF303030),
                fontSize: 20,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                decoration: showBenefits ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusOrBenefits() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Visibility(
        visible: showFocus || showBenefits,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showFocus) ...[
              _buildTextWithCircle('Improved Communication Skills',
                  'Enhances verbal and non-verbal communication through targeted interventions and practice.'),
              SizedBox(height: 10),
              _buildTextWithCircle('Enhanced Social Skills',
                  'Teaches effective social interactions and relationship-building techniques.'),
              SizedBox(height: 10),
              _buildTextWithCircle('Development of Daily Living Skills',
                  'Supports the acquisition of essential life skills, such as self-care and personal organization.'),
              SizedBox(height: 10),
              _buildTextWithCircle('Behavior Modification',
                  'Helps reduce problematic behaviors and replace them with positive, functional alternatives.'),
              SizedBox(height: 10),
              _buildTextWithCircle('Increased Independence',
                  'Promotes greater independence and self-sufficiency in daily activities.'),
            ],
            if (showBenefits) ...[
              _buildTextWithCircle(null,
                  'Have autism spectrum disorder (ASD)'),
              SizedBox(height: 10),
              _buildTextWithCircle(null,
                  'Experience difficulties with communication, social skills, or daily living skills'),
              SizedBox(height: 10),
              _buildTextWithCircle(null,
                  'Exhibit challenging behaviors that need to be addressed'),
              SizedBox(height: 10),
              _buildTextWithCircle(null,
                  'Are looking to enhance their overall functioning and quality of life'),
            ],
          ],
        ),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewListScreen(pageSource: "ABA Therapy",)));
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

  Widget _buildBottomBar(BuildContext context, double h, double w) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              _launchCall("8885320115");
            },
            child: Container(
              height: h * 0.06,
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
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Bookappointment(
                        pagesource: "ABA Therapy",
                      )));
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
    );
  }

  Widget _buildTextWithCircle(String? boldText, String normalText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.only(top: 6.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8.0),
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
