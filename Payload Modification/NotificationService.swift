//
//  NotificationService.swift
//  Payload Modification
//
//  Created by Jeremy Sharvit on 2019-01-27.
//  Copyright © 2019 com.notifs.Notifs. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    /*
     The first method is called when your notification arrives. You have roughly 30 seconds to perform whatever actions you need to take. If you run out of time, iOS will call the second method, serviceExtensionTimeWillExpire to give you one last chance to hurry up and finish.
     
     You may make any modification to the payload you want — except for one. You may not remove the alert text. If you don’t have alert text, then iOS will ignore your modifications and proceed with the original payload.
     
     Service extensions are also the place in which you can download videos or other content from the internet. First, you need to find the URL of the attached media. Once you have that, you can try to download it into a temporary directory somewhere on the user’s device. Once you have the data, you can create a UNNotificationAttachment object, which you can attach to the actual notifcation.
     
     To tell iOS that the service extension should be used, simply add a mutable-content key to the aps dictionary with an integer value of 1. You’ll notice that the provided sendEncrypted.php already includes this key for you.
     */
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "\(bestAttemptContent.title) modified"
            bestAttemptContent.body = "\(bestAttemptContent.body) modified"
            
            if let url = URL(string: "https://cdnph.upi.com/svc/sv/upi/8271527761456/2018/1/96078aac5da9b6f6d98622ee70beea69/Tom-Cruise-teases-Top-Gun-2-as-sequel-enters-production.jpg") {
                
                let destination = URL(fileURLWithPath: NSTemporaryDirectory())
                    .appendingPathComponent(url.lastPathComponent)
                
                do {
                    let data = try Data(contentsOf: url)
                    try data.write(to: destination)
                    
                    let attachment = try UNNotificationAttachment(identifier: "",
                                                                  url: destination)
                    
                    bestAttemptContent.attachments = [attachment]
                } catch {
                    // Nothing to do here.
                }
            }
            
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
