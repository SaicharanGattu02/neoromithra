import Flutter
import UIKit
import FirebaseCore
import UserNotifications
import GoogleMaps // Add this import

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Configure Firebase
    FirebaseApp.configure()

    // Initialize Google Maps with your API key
    GMSServices.provideAPIKey("AIzaSyD0-eauuJ1zBrknaL4uNexkR21cYVOkj7k") // Replace with your actual API key

    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // Request permission for push notifications (if required)
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if granted {
        DispatchQueue.main.async {
          application.registerForRemoteNotifications()
        }
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}