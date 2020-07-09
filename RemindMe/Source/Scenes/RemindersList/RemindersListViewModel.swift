//
//  RemindersListViewModel.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

struct ReminderListItem {
    let id: String
    let task: String
    let dueDate: Date
    let isCompleted: Bool
}

enum RemindersListPlaceholderType {
    case none
    case loading
    case empty
    case fetchFailed
    
    var placeholder: Placeholder? {
        switch self {
        case .loading:
            return Placeholder(loadingMsg: localized("Loading.."))
        case .fetchFailed:
            let icon = #imageLiteral(resourceName: "failed_placeholder")
            return Placeholder(type: .default, icon: icon,
                               title: "Failed to list reminders",
                               description: "Oops! we couldn't fetch reminders",
                               actionTitle: nil)
        case .empty:
            let icon = #imageLiteral(resourceName: "create_placeholder")
            return Placeholder(type: .default, icon: icon,
                               title: "Create your first reminder",
                               description: "Capture a relevant photo to quickly fill a task!",
                               actionTitle: nil)
        case .none:
            return nil
        }
    }
}

class RemindersListViewModel {
    var overdueReminders: Box<[ReminderListItem]>
    var reminders: Box<[ReminderListItem]>
    var placeholder: Box<RemindersListPlaceholderType>
    
    let worker = RemindersListWorker()
    
    init() {
        self.overdueReminders = Box([])
        self.reminders = Box([])
        self.placeholder = Box(.none)
    }
    
    func loadReminders() {
       let allReminders = worker.fetchReminders()
    }
}
