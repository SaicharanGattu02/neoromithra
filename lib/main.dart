import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:neuromithra/state_injector.dart';
import 'Presentation/LogIn.dart';
import 'Presentation/SplashScreen.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description:
        'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  Userapi.setupInterceptors(navigatorKey);
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyAJ_g_TtIFpj8FMAs1EpcE2mudfOFvtFK4",
            appId: "1:814004941342:android:fe8d8e1b907f639c72b40f",
            messagingSenderId: "814004941342",
            projectId: "neuromithra",
          ),
        )
      : await Firebase.initializeApp();

  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (Platform.isAndroid) {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("Androidfbstoken:{$token}");
      PreferenceService().saveString("fbstoken", token!);
      // toast(BuildContext , token);
    });
  } else {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("IOSfbstoken:{$token}");
      PreferenceService().saveString("fbstoken", token!);
      // toast(BuildContext , token);
    });
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings());

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {},
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      // print('A new message received: ${notification.title}');
      // print('RemoteMessage data: ${message.data.toString()}');
      showNotification(notification, android, message.data);
    }
  });

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    // _handleMessage(message);
    // print("onMessageOpenedApp:${message.data['type']}");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // debugInvertOversizedImages = true;
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  FlutterError.onError = (FlutterErrorDetails details) {
    // Log the error details to a logging service or print them
    print("Errrrrrrrrrr:${details.exceptionAsString()}");
    // Optionally report the error to a remote server
  };
// Motion.instance.setUpdateInterval(60.fps);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A Background message just showed up :  ${message.data}');
}

// Function to display local notifications
void showNotification(RemoteNotification notification,
    AndroidNotification android, Map<String, dynamic> data) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // Your channel ID
    'your_channel_name', // Your channel name
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    icon: '@mipmap/ic_launcher',
  );
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification.title,
    notification.body,
    platformChannelSpecifics,
    payload: jsonEncode(data),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: StateInjector.blocProviders,
      child: MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child ?? Container(),
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'NeuroMitra',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            cardColor: Colors.white,
            searchBarTheme: const SearchBarThemeData(),
            tabBarTheme: const TabBarTheme(),
            dialogTheme: const DialogTheme(
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)), // Set the border radius of the dialog
              ),
            ),
            buttonTheme: const ButtonThemeData(),
            popupMenuTheme: const PopupMenuThemeData(
                color: Colors.white, shadowColor: Colors.white),
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Colors.white,
            ),
            cardTheme: const CardTheme(
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              color: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(),
            ),
            bottomSheetTheme: const BottomSheetThemeData(
                surfaceTintColor: Colors.white, backgroundColor: Colors.white),
            colorScheme: const ColorScheme.light(background: Colors.white)
                .copyWith(background: Colors.white),
          ),
        routes: {
          '/signin': (context) => LogIn(),
        },
        home: Splash(),
      ),
    );
  }
}
