//
//  ReminderFormWorker.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import CoreData

class ReminderFormWorker {
    
    @discardableResult
    func saveReminder(_ reminderItem: ReminderItem) throws -> Reminder {
        let dataPersister = DataPersister.shared
        let managedContext = dataPersister.mainContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Reminder",
                                                in: managedContext)!
        let reminder = Reminder(entity: entity, insertInto: managedContext)
        reminder.create(using: reminderItem)
        
        try managedContext.save()
        return reminder
    }
    
    // MARK: - Fetch
    
    // implement methods here to fetch a reminder using ID for edit
    
    // MARK: - Reminder Notification
    func createReminderNotification(for reminder: Reminder) {
        // user doesn't wants a notification
        guard reminder.notify else {
            return
        }
        // ensure valid content
        guard let reminderID = reminder.reminderID, let task = reminder.task,
            let dueDate = reminder.dueDate else {
                Log.debug("This shouldn't happen")
                //todo throw proper error
                return
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        // ensure due date minus five mins has not passed already
        guard let fiveMinsAhead = calendar.date(byAdding: .minute, value: -5, to: dueDate),
            fiveMinsAhead > currentDate else {
                Log.info("That time has already passed")
                //todo throw proper error
                return
        }
        
        // we are good to take-off 🛫
        let configs = RemindNotificationConfig(task: task,
                                               reminderID: reminderID,
                                               date: dueDate)
        NotificationsWorker.scheduleNotification(for: configs)
        Log.info("Scheduled a notification for: \(reminderID)")
    }

}
