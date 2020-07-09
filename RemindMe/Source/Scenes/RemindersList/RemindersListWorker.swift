//
//  RemindersListWorker.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 10/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

class RemindersListWorker {
    
    lazy var activeRemindersPredicate: NSPredicate = {
        return NSPredicate(format: "%K = %d", #keyPath(Reminder.completed), false)
    }()
    
    func fetchReminders() -> [ReminderListItem] {
        let dataPersister = DataPersister.shared
        let context = dataPersister.mainContext
        
        let predicate = activeRemindersPredicate
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Reminder.dueDate), ascending: false)
        
        let reminders = dataPersister.fetchObjects(entity: Reminder.self,
                                                   predicate: predicate,
                                                   sortDescriptors: [sortDescriptor],
                                                   context: context)
        
        var reminderListItems = [ReminderListItem]()
        for reminder in reminders {
            guard let reminderID = reminder.reminderID, let task = reminder.task,
                let dueDate = reminder.dueDate else {
                    continue
            }
            let isCompleted = reminder.completed
            let reminderListItem = ReminderListItem(id: reminderID, task: task,
                                                    dueDate: dueDate, isCompleted: isCompleted)
            reminderListItems.append(reminderListItem)
        }
        
        return reminderListItems
    }
    
    // todo: make this a fetch requst for scale
    func filterOverdueReminders(from reminders: [ReminderListItem]) -> [ReminderListItem] {
        let currentDate = Date()
        return reminders.filter { $0.dueDate < currentDate }
    }
}
