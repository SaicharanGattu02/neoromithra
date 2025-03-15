
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onBackButtonPressed;
  final double toolbarHeight;

  CustomAppBar({
    required this.title,
    required this.onBackButtonPressed,
    this.toolbarHeight = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff86E7ED),
            Color(0xff72CCF2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Customize the leading icon
          onPressed: () {
            Navigator.pop(context); // Back navigation
          },
        ),
        title: Text(
          title, // Use the dynamic title
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            color: Colors.black, // Set text color
          ),
        ),
        backgroundColor: Colors.transparent, // Make the AppBar background transparent
        elevation: 0, // Remove shadow
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

}