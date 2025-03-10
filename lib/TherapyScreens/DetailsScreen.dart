import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/ReviewListModel.dart';
import '../ReviewListScreen.dart';
import '../services/userapi.dart';
import '../utils/ReviewCard.dart';

class DetailsScreen extends StatefulWidget {
  final String assetImage;
  final String title;
  final String descHeading1;
  final String description1;
  final String descHeading2;
  final String description2;
  final List<String> keyAreas;
  final List<String> benefits;

  const DetailsScreen({
    super.key,
    required this.assetImage,
    required this.title,
    required this.descHeading1,
    required this.description1,
    required this.descHeading2,
    required this.description2,
    required this.keyAreas,
    required this.benefits,
  });

  @override
  State<DetailsScreen> createState() => _TherapyDetailsScreenState();
}

class _TherapyDetailsScreenState extends State<DetailsScreen> {
  bool showFocus = true;

  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }

  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist(widget.title);
    if (response != null) {
      setState(() {
        reviews=response.review??[];
      });
    }
  }

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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: h * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.assetImage,
                  width: w,
                  height: h * 0.3,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.description1,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _tabButton("Key Areas of Focus", showFocus, () {
                        setState(() {
                          showFocus = true;
                        });
                      }),
                      SizedBox(width: 20),
                      _tabButton("Benefits", !showFocus, () {
                        setState(() {
                          showFocus = false;
                        });
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: showFocus ? _buildPoints(widget.keyAreas) : _buildPoints(widget.benefits),
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
                _bottomButton("Call Us", Colors.blue, () => _launchCall("8885320115")),
                _bottomButton("Book Appointment", Colors.blue, () {
                  // Navigate to appointment booking screen
                }),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewListScreen(pageSource: widget.title,)));
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

  Widget _tabButton(String text, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black54,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          decoration: isActive ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }

  List<Widget> _buildPoints(List<String> points) {
    return points.map((point) => _buildTextWithCircle(point)).toList();
  }

  Widget _buildTextWithCircle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.only(top: 6.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16.0, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(String text, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
