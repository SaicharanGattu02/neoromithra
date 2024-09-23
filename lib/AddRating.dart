import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProductRating extends StatefulWidget {
  const AddProductRating({super.key,});

  @override
  State<AddProductRating> createState() => _AddProductRatingState();
}

class _AddProductRatingState extends State<AddProductRating> {

  var bar;
  bool isLoading = false;

  var image = "";
  var rating = 0;
  var image_picked = 0;

  var is_tapped = false;
  List<bool> starStates = [false, false, false, false, false];
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _headlineController = TextEditingController();
  bool isFocused = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(screenName: "Add Rating");
    _focusNode.addListener(_onFocusChange);
    updateStarStates(rating, starStates);
    super.initState();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  void updateStarStates(int rating, List<bool> starStates) {
    // Reset all stars to false
    starStates.fillRange(0, starStates.length, false);

    // Set stars according to rating
    for (int i = 0; i < rating; i++) {
      starStates[i] = true;
    }
    // print(starStates);
  }


  var buttonLoading = false;



  Future<bool> _onBackPressed() async {
    Navigator.pop(context, true);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _scaffold(context)
    );
  }

  Widget _scaffold(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xffF4F5FA),
        appBar: AppBar(title: Text("Write a review"),),
        body: SingleChildScrollView(
          child: Padding(
              padding: (Platform.isAndroid)
                  ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom)
                  : EdgeInsets.all(0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rating',
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize:20)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Row(
                                    children: List.generate(
                                      starStates.length,
                                          (index) => InkWell(
                                        onTap: () {
                                          // toast(context, "${index + 1}"); // Display the selected star's rating
                                          setState(() {
                                            rating = index + 1;
                                            // toast(context,rating);
                                            for (int i = 0;
                                            i < starStates.length;
                                            i++) {
                                              starStates[i] = i <= index;
                                              // rating = i + 1;// Set the state of stars based on the tapped star
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              starStates[index]
                                                  ? Icons.star
                                                  : Icons.star,
                                              color: starStates[index]
                                                  ? Color(0xffFFB703)
                                                  : Color(0xffD9D9D9),
                                              size: 35,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: TextField(
                              focusNode: _focusNode,
                              onTapOutside: (event) {
                                _focusNode.unfocus();
                                setState(() {
                                  isFocused = false;
                                });
                              },
                              onTap: () {
                                setState(() {
                                  isFocused = true;
                                });
                              },
                              keyboardType: TextInputType.text,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize:  18
                                      ),
                              enableSuggestions: false,
                              controller: _headlineController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        _headlineController.text.length > 0
                                            ? Colors.black
                                            : Color(0xffE8ECFF),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(35)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(35)),
                                contentPadding: EdgeInsets.only(left: 25),
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                label: Container(
                                    width: (isFocused) ? 100 : 40,
                                    height: 23,
                                    decoration: BoxDecoration(
                                      color: (isFocused)
                                          ? Color(0xffF4F5FA)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Title",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: (isFocused)
                                              ? Colors.black
                                              : Color(0xffB9BEDA),
                                          fontFamily: "Inter",
                                          fontSize: 13, // Background color of the label text
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Optional",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      color: Color(0xffCED2E8),
                                      fontWeight: FontWeight.w500,
                                      fontSize:10)),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xffE8ECFF))),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              cursorWidth: 1,
                              scrollPadding: const EdgeInsets.only(top: 5),
                              controller: _reviewController,
                              textInputAction: TextInputAction.done,
                              maxLines: 100,
                              decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(left: 30, top: 10),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Write a message",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffB9BEDA),
                                  )),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Optional",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      color: Color(0xffCED2E8),
                                      fontWeight: FontWeight.w500,
                                      fontSize:10)),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: screenWidth * 0.88,
                            child:InkResponse(
                          onTap: () {
                          },
                          child: Container(
                            height: 40,
                            width: screenWidth * 0.88,
                            decoration: BoxDecoration(
                                color: (rating == 0)
                                    ? Color(0xffF4F5FA)
                                    : Color(0xffE7A500),
                                border: Border.all(
                                    color: (rating == 0)
                                        ? Color(0xffE0E3F1)
                                        : Colors.transparent),
                                borderRadius: BorderRadius.circular(
                                  39,
                                )),
                            child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      color: (rating == 0)
                                          ? Colors.grey
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize:13),
                                ),
                                )
                          ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )),
        ));
  }
}
