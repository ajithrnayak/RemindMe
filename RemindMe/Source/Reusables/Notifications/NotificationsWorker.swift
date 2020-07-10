//
//  NotificationsWorker.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 10/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UserNotifications

struct RemindNotificationConfig {
    let task: String
    let reminderID: String
    let date: Date
}

final class NotificationsWorker {
    
    static func requestUserPermision(onCompletion: @escaping (_ isSuccess: Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            onCompletion(granted)
            if granted {
                Log.info("Yay!")
            } else {
                Log.warning("D'oh")
            }
        }
    }
    
    static func hasUserAuthorizedNotifications(onCompletion: @escaping (_ allowed: Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            onCompletion(settings.authorizationStatus == .authorized)
        }
    }
    
    static func scheduleNotification(for configs: RemindNotificationConfig) {
        let content = UNMutableNotificationContent()
        content.title = "Hey there! I'm just doing my job."
        content.body = "\(configs.task) up in about 5 mins.."
        content.userInfo = ["customData": configs.reminderID]
        
        let date = configs.date
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                          from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifier = configs.reminderID
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    static func removeNotification(for reminderID: String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [reminderID])
    }
    
    static func removeAllPendingNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    
    static func removeAllDeliveredNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
    }
}
