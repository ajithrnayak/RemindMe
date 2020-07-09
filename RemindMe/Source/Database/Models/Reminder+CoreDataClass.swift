//
//  Reminder+CoreDataClass.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//
//

import Foundation
import CoreData

public class Reminder: NSManagedObject {
    
    func create(using reminderItem: ReminderItem) {
        let newReminderID = UUID().uuidString
        self.reminderID = newReminderID
        self.notify     = reminderItem.notify
        self.taskType   = reminderItem.taskType.rawValue
        self.task       = reminderItem.reminderTask
        self.dueDate    = reminderItem.dueDate
        self.completed = false
        self.isRemoved = false
    }
}
