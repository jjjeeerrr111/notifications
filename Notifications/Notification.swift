//
//  Notification.swift
//  Notifications
//
//  Created by Jeremy Sharvit on 2019-01-27.
//  Copyright © 2019 com.notifs.Notifs. All rights reserved.
//

import Foundation
extension Notification.Name {

    static let viewMessageButton = Notification.Name("viewMessageTapped")
    // 2
    func post(center: NotificationCenter = NotificationCenter.default, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        
        center.post(name: self, object: object, userInfo: userInfo)
    }
    // 3
    @discardableResult
    func onPost(center: NotificationCenter = NotificationCenter.default, object: Any? = nil, queue: OperationQueue? = nil, using: @escaping (Notification) -> Void) -> NSObjectProtocol {
        
        return center.addObserver(forName: self, object: object, queue: queue, using: using)
    }
    
}
