import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:neuromithra/services/userapi.dart';

class AddProductRating extends StatefulWidget {
  final app_id;
  final page_source;
  const AddProductRating(
      {super.key, required this.app_id, required this.page_source});
  @override
  State<AddProductRating> createState() => _AddProductRatingState();
}

class _AddProductRatingState extends State<AddProductRating> {
  var bar;
  bool isLoading = false;
  var rating = 0;

  var is_tapped = false;
  List<bool> starStates = [false, false, false, false, false];
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    updateStarStates(rating, starStates);
    super.initState();
  }

  void updateStarStates(int rating, List<bool> starStates) {
    starStates.fillRange(0, starStates.length, false);
    for (int i = 0; i < rating; i++) {
      starStates[i] = true;
    }
  }

  Future<void> SubmitReview() async {
    final data = await Userapi.SubmitReviewApi(
        widget.app_id.toString(), widget.page_source, rating.toString(), _reviewController.text);
    if (data != "") {
      setState(() {
        if(data?.status==true){
          isLoading=false;
          Navigator.pop(context,true);
        }else{
          isLoading=false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please give your valuable feedback!',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
              ),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.blue,
            ),
          );
        }
      });
    } else {
      print("Data not fetched.");
    }
  }

  var buttonLoading = false;

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _scaffold(context));
  }

  Widget _scaffold(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xffF4F5FA),
        appBar: AppBar(
          title: Text("Write a review"),
        ),
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
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(1, 1))
                        ],
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
                                  fontSize: 20)),
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
                          SizedBox(
                            height: 25,
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
                                  hintText: "Write a feedback",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffB9BEDA),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 105,
                    ),
                    InkResponse(
                      onTap: () {
                        if(rating>0){
                          if(isLoading){

                          }else{
                            setState(() {
                              isLoading=true;
                            });
                            SubmitReview();
                          }
                        }
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
                            child:(isLoading && rating>0)?CircularProgressIndicator(
                              color: Colors.white,
                            ):
                            Text(
                              "Submit",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  color: (rating == 0)
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                          )),
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
