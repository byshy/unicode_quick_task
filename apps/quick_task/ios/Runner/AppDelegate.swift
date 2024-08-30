import Flutter
import UIKit
import FirebaseCore
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        FirebaseApp.configure()
        
        WorkmanagerPlugin.registerTask(withIdentifier: "com.unicode.bg_sync_todos")
        
        GeneratedPluginRegistrant.register(with: self)
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
        
        WorkmanagerPlugin.setPluginRegistrantCallback { registry in
            GeneratedPluginRegistrant.register(with: registry)
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping
    (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
