import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Presentation/BookAppointment.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/ReviewListModel.dart';
import '../utils/Color_Constants.dart';
import 'ReviewListScreen.dart';
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
    if(widget.keyAreas.length==0){
      setState(() {
        showFocus = false;
      });
    }
  }

  List<Review> reviews = [];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getReviewList(widget.title);
    if (response != null) {
      setState(() {
        reviews = response.review ?? [];
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
        title: Text(widget.title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: primarycolor,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
          onPressed: () => context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
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
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Price : ₹800 /-",
                    style: TextStyle(
                        fontSize: 18,
                        color: primarycolor,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter"),
                  ),
                ),
                if(widget.descHeading1!="")...[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Text(
                      widget.descHeading1,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter"),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Text(
                    widget.description1,
                    style: TextStyle(
                        fontSize: 16, height: 1.5, fontFamily: "Inter"),
                  ),
                ),
                if(widget.descHeading2!="")...[
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: Text(
                      widget.descHeading2,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      widget.description2,
                      style: TextStyle(
                          fontSize: 16, height: 1.5, fontFamily: "Inter"),
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      if(widget.keyAreas.length!=0)...[
                        _tabButton("Key Areas of Focus", showFocus, () {
                          setState(() {
                            showFocus = true;
                          });
                        }),
                        SizedBox(width: 20,),
                      ],

                      if(widget.benefits.length!=0)...[
                        _tabButton("Benefits", !showFocus, () {
                          setState(() {
                            showFocus = false;
                          });
                        }),
                      ]
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: showFocus
                        ? _buildPoints(widget.keyAreas)
                        : _buildPoints(widget.benefits),
                  ),
                ),
                SizedBox(height: 20),
                if (reviews.length > 0) ...[
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
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          color: Colors.white, // Optional: background for visibility
          child: Row(
            children: [
              Expanded(
                child: _bottomButton(
                  "Call Us",
                  const Color(0xff0094FE),
                      () => _launchCall("8885320115"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _bottomButton(
                  "Book Now",
                  const Color(0xff0933A1),
                      () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Bookappointment(pagesource: widget.title);
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
            physics:
                NeverScrollableScrollPhysics(), // Disable scrolling on this ListView
            shrinkWrap:
                true, // Allows the ListView to take the height of its children
            itemBuilder: (context, index) {
              return ReviewCard(
                customerName: reviews[index].userName ?? "",
                rating: reviews[index].rating ?? 0,
                review: reviews[index].details ?? "",
              );
            },
          ),
          if (reviews.length > 3)
            InkResponse(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewListScreen(
                              pageSource: widget.title,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'More >>',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
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
          color: isActive ? Color(0xff007BFF) : Colors.black,
          fontSize: 18,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          decoration: isActive ? TextDecoration.underline : TextDecoration.none,
          decorationColor: isActive ? Color(0xff007BFF) : Colors.black54,
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
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 16.0, height: 1.4, fontFamily: "Inter")),
          ),
        ],
      ),
    );
  }
  Widget _bottomButton(String text, Color color, VoidCallback onTap) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            elevation: 0, // Shadow effect
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
