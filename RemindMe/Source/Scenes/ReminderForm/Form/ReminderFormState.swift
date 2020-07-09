//
//  ReminderFormState.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

struct Reminder {
    var taskType: TaskType
    var reminderTask: String
    var dueDate: Date
    var notify: Bool
}

struct ReminderFormState {
    var reminder: Reminder?
    var inputImage: UIImage?
    
    init(inputImage: UIImage) {
        self.inputImage = inputImage
        self.reminder = nil
    }
    
    init(reminder: Reminder) {
        self.reminder = reminder
        self.inputImage = nil
    }
    
    var isNewReminder: Bool {
        return reminder == nil
    }
}
