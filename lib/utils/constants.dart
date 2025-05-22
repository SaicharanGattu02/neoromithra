import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Color_Constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const authorization = "Authorization";
const double defaultPadding = 20.0;



void showAnimatedTopSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;
  final animationController = AnimationController(
    vsync: Navigator.of(context),
    duration: Duration(milliseconds: 300),
  );
  final animation =
  CurvedAnimation(parent: animationController, curve: Curves.easeOut);

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value,
              child: Transform.translate(
                offset: Offset(0, -50 + 50 * animation.value), // slide down
                child: child,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: primarycolor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "general_sans",
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  animationController.forward();

  Future.delayed(Duration(seconds: 2), () {
    animationController.reverse().then((_) {
      overlayEntry.remove();
      animationController.dispose();
    });
  });
}