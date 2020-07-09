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
    
    func saveReminder(_ reminderItem: ReminderItem) throws {
        
        let dataPersister = DataPersister.shared
        let managedContext = dataPersister.mainContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Reminder",
                                                in: managedContext)!
        let reminder = Reminder(entity: entity, insertInto: managedContext)
        reminder.create(using: reminderItem)
        
        try managedContext.save()
    }
    
    // MARK: - Fetch
    
    // implement methods here to fetch a reminder using ID for edit
    
}
