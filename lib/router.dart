import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/main.dart';
import 'Presentation/ForgotPasswordScreen.dart';
import 'Presentation/LogIn.dart';
import 'Presentation/MainDashBoard.dart';
import 'Presentation/OnBoardScreen.dart';
import 'Presentation/Register.dart';
import 'Presentation/SplashScreen.dart';

final GoRouter goRouter =
    GoRouter(initialLocation: '/', navigatorKey: navigatorKey, routes: [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => buildSlideTransitionPage(Splash(), state),
  ),
  GoRoute(
    path: '/on_boarding',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(OnBoardScreen(), state),
  ),
  GoRoute(
    path: '/login',
    pageBuilder: (context, state) => buildSlideTransitionPage(LogIn(), state),
  ),
  GoRoute(
    path: '/register',
    pageBuilder: (context, state) => buildSlideTransitionPage(Register(), state),
  ),
  GoRoute(
    path: '/forgot_password',
    pageBuilder: (context, state) => buildSlideTransitionPage(ForgotPasswordScreen(), state),
  ),
  GoRoute(
    path: '/main_dashBoard',
    pageBuilder: (context, state) {
      final initialIndex =
          int.tryParse(state.uri.queryParameters['initialIndex'] ?? '0') ?? 0;
      return buildSlideTransitionPage(
          MainDashBoard(initialIndex: initialIndex), state);
    },
  ),
]);

Page<dynamic> buildSlideTransitionPage(Widget child, GoRouterState state) {
  if (Platform.isIOS) {
    return CupertinoPage(key: state.pageKey, child: child);
  }

  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
