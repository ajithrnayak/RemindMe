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
    
    var dueDateString: String? {
        return formatter.string(from: dueDate)
    }
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm E, d MMM y"
        return df
    }()
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
    var allReminders: [ReminderListItem]?
    
    let worker = RemindersListWorker()
    
    init() {
        self.overdueReminders = Box([])
        self.reminders = Box([])
        self.placeholder = Box(.none)
    }
    
    func loadReminders() {
        let allReminders = worker.fetchReminders()
        self.allReminders = allReminders
        presentReminders(allReminders)
    }
    
    func presentReminders(_ reminders: [ReminderListItem]) {
        // hide/show placeholder
        if reminders.isEmpty {
            self.placeholder.value = .empty
        }
        else {
            self.placeholder.value = .none
        }
        let overdueReminders        = worker.filterOverdueReminders(from: reminders)
        self.overdueReminders.value = overdueReminders
        self.reminders.value        = reminders
    }
    
    // MARK: - data source
    var numberOfSections: Int {
        if reminders.value.isEmpty {
            return 0
        }
        else if overdueReminders.value.isEmpty {
            return 1
        }
        else {
            return 2
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 0:
            return numberOfSections == 2 ? overdueReminders.value.count : reminders.value.count
        case 1:
            return reminders.value.count
        default:
            return 0
        }
    }
    
    func sectionTitle(for section: Int) -> String {
        switch section {
        case 0:
            return numberOfSections == 2 ? "Overdue" : "All"
        case 1:
            return "All"
        default:
            return ""
        }
    }
    
    func reminder(at indexpath: IndexPath) -> ReminderListItem? {
        switch indexpath.section {
        case 0:
            return numberOfSections == 2 ? overdueReminders.value[indexpath.row] : reminders.value[indexpath.row]
        case 1:
            return reminders.value[indexpath.row]
        default:
            return nil
        }
    }
    
    // MARK: - Update
    func completeReminder(with reminderID: String) {
        do {
            try worker.completeReminder(with: reminderID)
            loadReminders()
            Log.verbose("Updated reminder with ID: \(reminderID)")
        }
        catch {
            Log.error("Failed to update reminder")
        }
        // remove notification even if core data save failed
        worker.removeNotification(for: reminderID)
    }

    func searchReminder(for searchString: String?) {
        guard let searchString = searchString, !searchString.isEmpty else {
            // reset data source
            presentReminders(self.allReminders ?? [])
            return
        }
        
        guard !self.reminders.value.isEmpty else {
            return
        }
        
        let searchResults = self.reminders.value.filter { (reminder) -> Bool in
            return reminder.task.localizedCaseInsensitiveContains(searchString)
        }
        
        presentReminders(searchResults)
    }
}
