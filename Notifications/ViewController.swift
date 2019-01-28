//
//  ViewController.swift
//  Notifications
//
//  Created by Jeremy Sharvit on 2019-01-27.
//  Copyright © 2019 com.notifs.Notifs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        //register to the notification button pressed
        Notification.Name.viewMessageButton.onPost { [weak self] _ in
            self?.view.backgroundColor = .purple
        }

    }


}

