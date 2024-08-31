import UIKit
import Flutter
import Firebase
import FirebaseMessaging
import flutter_background_service_ios

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        application.isIdleTimerDisabled = true
        
        SwiftFlutterBackgroundServicePlugin.taskIdentifier = "com.carepay.moveToEarn"
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
              application.registerForRemoteNotifications()
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().delegate = self

        application.registerForRemoteNotifications()

        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }

        Messaging.messaging().isAutoInitEnabled = true

        GeneratedPluginRegistrant.register(with: self)
        
        if #available(iOS 10, *){
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
}
