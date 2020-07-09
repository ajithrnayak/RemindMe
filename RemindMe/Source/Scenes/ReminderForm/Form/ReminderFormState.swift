//
//  ReminderFormState.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

struct ReminderItem {
    let taskType: TaskType
    var reminderTask: String?
    var dueDate: Date
    var notify: Bool
    let reminderID: String
}

extension ReminderItem {
    init?(identifier: String) {
        guard let taskType = TaskType(objectIdentifier: identifier) else {
            return nil
        }
        let newReminderID = UUID().uuidString
        self.reminderID = newReminderID
        self.taskType   = taskType
        self.reminderTask = nil
        self.dueDate    = Date()
        self.notify     = true
    }
}

struct ReminderFormState {
    var reminder: ReminderItem?
    var inputImage: UIImage?
    
    init(inputImage: UIImage) {
        self.inputImage = inputImage
        self.reminder = nil
    }
    
    init(reminder: ReminderItem) {
        self.reminder = reminder
        self.inputImage = nil
    }
    
    var isNewReminder: Bool {
        return reminder == nil
    }
}
