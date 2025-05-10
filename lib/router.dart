import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Presentation/AddAddressScreen.dart';
import 'package:neuromithra/Presentation/AddressListScreen.dart';
import 'package:neuromithra/Presentation/BookAppointment.dart';
import 'package:neuromithra/Presentation/ServiceDeailsScreen.dart';
import 'package:neuromithra/utils/constants.dart';
import 'Assesment/ResultScreen.dart';
import 'Presentation/Bookappointment1.dart';
import 'Presentation/Authentication/LogInWithMobile.dart';
import 'Presentation/Authentication/Otp.dart';
import 'Presentation/BookedApointmentsuccessfully.dart';
import 'Presentation/ForgotPasswordScreen.dart';
import 'Presentation/BookingHistory.dart';
import 'Presentation/LogIn.dart';
import 'Presentation/Authentication/ForgotPasswordScreen.dart';
import 'Presentation/LastBooking.dart';
import 'Presentation/Authentication/LogIn.dart';
import 'Presentation/MainDashBoard.dart';
import 'Presentation/OnBoardScreen.dart';
import 'Presentation/PaymentStatusScreen.dart';
import 'Presentation/Authentication/Register.dart';
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
        path: '/otp',
        pageBuilder: (context, state) {
          final mobile = state.uri.queryParameters['mobile'];
          if (mobile == null || mobile.isEmpty) {
            return buildSlideTransitionPage(
              const Scaffold(
                body: Center(child: Text('Error: Mobile number missing')),
              ),
              state,
            );
          }
          return buildSlideTransitionPage(Otp(mobile: mobile), state);
        },
      ),
  GoRoute(
    path: '/register',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(Register(), state),
  ),
  GoRoute(
    path: '/appointment_success',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(ApointmentSuccess(), state),
  ),
  GoRoute(
      path: '/result_screen',
      pageBuilder: (context, state) {
        final resultData = state.extra as Map<String, dynamic>;
        final role = state.uri.queryParameters['role'] ?? "";
        return buildSlideTransitionPage(
            Resultscreen(
              resultData: resultData,
              role: role,
            ),
            state);
      }),
  GoRoute(
      path: '/payment_status',
      pageBuilder: (context, state) {
        final res = state.extra as Map<String, dynamic>;
        final addressId = state.uri.queryParameters['addressId'] ?? "";
        final age = state.uri.queryParameters['age'] ?? "";
        final amount = state.uri.queryParameters['amount'] ?? "";
        final appointment = state.uri.queryParameters['appointment'] ?? "";
        final appointmentType =
            state.uri.queryParameters['appointmentType'] ?? "";
        final date = state.uri.queryParameters['date'] ?? "";
        final fullName = state.uri.queryParameters['fullName'] ?? "";
        final pageSource = state.uri.queryParameters['pageSource'] ?? "";
        final patientId = state.uri.queryParameters['patientId'] ?? "";
        final phoneNumber = state.uri.queryParameters['phoneNumber'] ?? "";
        final timeOfAppointment =
            state.uri.queryParameters['timeOfAppointment'] ?? "";
        final userId = state.uri.queryParameters['userId'] ?? "";
        final transactionId = state.uri.queryParameters['transactionId'] ?? "";
        final onSuccess = res['onSuccess'] as VoidCallback;
        final isExistingPatient = res['isExistingPatient'] as bool? ?? false;
        return buildSlideTransitionPage(
            PaymentStatusScreen(
              response: res,
              addressId: addressId,
              age: age,
              amount: amount,
              appointment: appointment,
              appointmentType: appointmentType,
              date: date,
              fullName: fullName,
              pageSource: pageSource,
              patientId: patientId,
              phoneNumber: phoneNumber,
              timeOfAppointment: timeOfAppointment,
              userId: userId,
              transactionId: transactionId,
              onSuccess: onSuccess,
              isExistingPatient: isExistingPatient,
            ),
            state);
      }),
  GoRoute(
    path: '/forgot_password',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(ForgotPasswordScreen(), state),
  ),
      GoRoute(
    path: '/login_with_mobile',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(LoginWithMobile(), state),
  ),
  GoRoute(
    path: '/booking_history',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(BookingHistory(), state),
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
  GoRoute(
    path: '/book_appointment',
    pageBuilder: (context, state) {
      final pagesource = state.uri.queryParameters['pagesource'] ?? '0';
      return buildSlideTransitionPage(
          Bookappointment(pagesource: pagesource), state);
    },
  ),
  GoRoute(
    path: '/book_appointment1',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(Bookappointment1(), state),
  ),
  GoRoute(
    path: '/address_list',
    pageBuilder: (context, state) =>
        buildSlideTransitionPage(AddressListScreen(), state),
  ),
  GoRoute(
    path: '/add_address',
    pageBuilder: (context, state) {
      final id = state.uri.queryParameters['id'] ?? '';
      final type = state.uri.queryParameters['type'] ?? '';
      return buildSlideTransitionPage(
          AddAddressScreen(
            id: id,
            type: type,
          ),
          state);
    },
  ),
  GoRoute(
    path: '/service_details_screen',
    pageBuilder: (context, state) {
      final serviceID = state.uri.queryParameters['serviceID'] ?? '';
      final serviceName = state.uri.queryParameters['serviceName'] ?? '';
      return buildSlideTransitionPage(
          ServiceDetailsScreen(serviceID: serviceID, serviceName: serviceName),
          state);
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
