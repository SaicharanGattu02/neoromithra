
import 'package:flutter/material.dart';


import 'constants.dart';


class CustomSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontFamily: "Inter"),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }
}


