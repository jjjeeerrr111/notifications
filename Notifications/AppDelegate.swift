//
//  AppDelegate.swift
//  Notifications
//
//  Created by Jeremy Sharvit on 2019-01-27.
//  Copyright © 2019 com.notifs.Notifs. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationDelegate = NotificationDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert]) { granted, _ in
            guard granted else { return }
            center.delegate = self.notificationDelegate
            self.notificationDelegate.registerCustomActions()
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
        print(token)
        
        /*
         Name:
         Push Notification Key
         Key ID:
         6YBTTRTQF2
         team id: 3K2CLC6A83
         device token: 2ccc9c8709addc67cdd036e64ecc2050629f9ccb19deddc748cfe599c28c36af
         */
    }
    
    // This is called when "content-available" (silent notification) flag is included in the aps payload
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("silent notification received")
//        guard let text = userInfo["text"] as? String, let image = userInfo["image"] as? String, let url = URL(string: image) else {
//            completionHandler(.noData)
//            return
//        }
        
    }
}
