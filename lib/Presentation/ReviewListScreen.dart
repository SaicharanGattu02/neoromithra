import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:neuromithra/utils/ReviewCard.dart';

import '../Model/ReviewListModel.dart';

class ReviewListScreen extends StatefulWidget {
  final pageSource;

  const ReviewListScreen({Key? key, required this.pageSource}) : super(key: key);

  @override
  _ReviewListScreenState createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  void initState() {
    super.initState();
    GetReviewsList();
  }
  List<Review> reviews=[];
  Future<void> GetReviewsList() async {
    final response = await Userapi.getreviewlist(widget.pageSource);
    if (response != null) {
      setState(() {
        reviews=response.review??[];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F5FA),
      appBar: AppBar(
        title: Text('Customer Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return ReviewCard(
              customerName: reviews[index].userName??"",
              rating: reviews[index].rating??0,
              review: reviews[index].details??"",
            );
          },
        ),
      ),
    );
  }
}
