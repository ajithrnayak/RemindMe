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
    var dueDate: Date?
    var notify: Bool
    
    var dueDateString: String? {
        return dueDate == nil ? nil : formatter.string(from: dueDate!)
    }
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm E, d MMM y"
        return df
    }()
}

extension ReminderItem {
    init?(identifier: String) {
        guard let taskType = TaskType(objectIdentifier: identifier) else {
            return nil
        }
        
        self.taskType   = taskType
        self.reminderTask = nil
        self.dueDate    = nil
        self.notify     = true
    }
}

struct ReminderFormState {
    var reminder: ReminderItem?
    var inputImage: UIImage?
    var reminderID: String?
    
    init(inputImage: UIImage) {
        self.inputImage = inputImage
        self.reminder = nil
    }
    
    init(reminderID: String) {
        self.reminderID = reminderID
        self.inputImage = nil
    }
    
    var isNewReminder: Bool {
        return reminderID == nil
    }
}
