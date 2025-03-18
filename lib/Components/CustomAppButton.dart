import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/Color_Constants.dart';


class CustomAppButton extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color? color;
  final double? width;
  final double? height;
  final VoidCallback? onPlusTap;
  final bool isLoading; // New parameter to track loading state

  CustomAppButton({
    Key? key,
    required this.text,
    required this.onPlusTap,
    this.color,
    this.height,
    this.width,
    this.isLoading = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return
      SizedBox(
      width: width ?? w,
      height: height ?? 48,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: MaterialStateProperty.all(color ?? primary),
        ),
        onPressed: isLoading ? null : onPlusTap, // Disable button if loading
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Text(
          text,
          style: TextStyle(
            color: color??Colors.white,
            fontSize:(15),
            fontWeight: FontWeight.w700,
            fontFamily: 'Epi',
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}

