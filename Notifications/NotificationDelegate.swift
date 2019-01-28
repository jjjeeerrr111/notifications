//
//  NotificationDelegate.swift
//  Notifications
//
//  Created by Jeremy Sharvit on 2019-01-27.
//  Copyright © 2019 com.notifs.Notifs. All rights reserved.
//

import UIKit
import UserNotifications

final class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    private let categoryIdentifier = "ViewMessageIdentifier"
    
    private enum ActionIdentifier: String {
        case viewMessage
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("did receive notification")
        defer { completionHandler() }
        //guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else { return }
        
        
        let identity = response.notification.request.content.categoryIdentifier
        guard identity == categoryIdentifier, let action = ActionIdentifier(rawValue: response.actionIdentifier) else { return }
        
        let userInfo = response.notification.request.content.userInfo
        switch action {
        case .viewMessage:
            Notification.Name.viewMessageButton.post(userInfo: userInfo)
        }
        
        print("You pressed \(response.actionIdentifier)")
        
        // Perform actions here
    }
    
    func registerCustomActions() {
        let accept = UNNotificationAction(identifier: ActionIdentifier.viewMessage.rawValue, title: "View Message", options: [.foreground, .authenticationRequired])
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [accept], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}

/*
 
 APNS notifications
 
 Adding "content-available": 1 key to the aps payload will initiate background mode fetch (silent notificaiton). Remove the entire key if you dont want it to be silent/
 example payload:
 
 {
 "aps": {
 "content-available" : 1
 "alert": {
     "title": "3D Touch this notification (long-press)"
 },
 "sound": "default"
 }
 }
 
 Adding "category" key with the correct identifier will register Action buttons and attach them to the notification depending on which category comes in.
 example payload:
 
 {
 "aps": {
     "alert": {
         "title": "This notification will attach a 'View Message' button to directly open the notification"
        },
     "category": "ViewMessageIdentifier",
     "sound": "default"
     }
 }
 
 Adding the "mutable-content" : 1 key pair will allow you to create a notification service extension in which you can modify the payload if needed. for exmaple displaying an image/video as a content attachement. See the notificationService.swift file to see the implementation. Be sure to remove the key "mutable-content" for notifications that do not require to be modified.
 example payload:
 
 {
     "aps": {
     "alert": {
         "title": "hi",
         "body": "this is a body"
     },
     "sound": "default",
     "mutable-content": 1,
     "media-url": "https://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"
     }
 }
 */
