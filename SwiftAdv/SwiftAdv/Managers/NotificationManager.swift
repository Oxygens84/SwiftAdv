//
//  NotificationManager.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 24/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager {
    
    var center = UNUserNotificationCenter.current();
    var authStatus: Bool = false;
    
    func notificationAuth(){
        center.requestAuthorization(
            //.alert, .sound, .badge, .provisional
            options: [.alert, .sound, .badge]) { (result, error) in
                if result {
                    self.authStatus = result
                    self.center.getNotificationSettings(completionHandler: { (settings) in
                        self.getAuthStatusDescription()
                    })
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                } else {
                    self.authStatus = result
                    self.getAuthStatusDescription()
                    print(error!)
                }
        }
    }
    
    func getAuthStatusDescription(){
        center.getNotificationSettings(completionHandler: { (settings) in
            switch settings.authorizationStatus {
                case .authorized:
                    print("notification authorized")
                case .denied:
                    print("notification denied")
                case .notDetermined:
                   print("notification notDetermined")
                case .provisional:
                    print("notification provisional")
                @unknown default:
                    print("unexpected status")
            }
        })
    }
    
    func makeNotificationContent(_ badge: Int) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = Titles.notification.rawValue
        content.body = Messages.newMessage.rawValue
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        return content
    }
    
    func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(
            //every 30 min 
            timeInterval: 30*60,
            repeats: true
        )
    }
    
    func makeCalendarNotificatioTrigger() -> UNNotificationTrigger {
        var dateInfo = DateComponents()
        dateInfo.hour = 7
        dateInfo.minute = 0
        return UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
    }


    func sendNotificatioRequest(
        content: UNNotificationContent,
        trigger: UNNotificationTrigger) {
        
        let request = UNNotificationRequest(
            identifier: "alarm",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
