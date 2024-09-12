
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onBackButtonPressed;
  final double toolbarHeight;

  CustomAppBar({
    required this.title,
    required this.onBackButtonPressed,
    this.toolbarHeight = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: "Inter",
        ), // Set the title text color
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color(0xFF000000),), // Set the back button color
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Color(0xFFFFFFFF), // Set your preferred background color
      toolbarHeight: toolbarHeight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);


}