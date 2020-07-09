//
//  ReminderFormViewModel.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

enum ReminderFormPlaceholderType {
    case loading
    case processing
    case failedToProcess
    case unknownObjectType
    case empty
    case none
    
    var placeholder: Placeholder? {
        switch self {
        case .loading:
            return Placeholder(loadingMsg: localized("Loading.."))
        case .processing:
            return Placeholder(loadingMsg: localized("Processing.."))
        case .failedToProcess:
            let icon = #imageLiteral(resourceName: "failed_placeholder")
            return Placeholder(type: .default, icon: icon,
                               title: "Failed to process image",
                               description: "Oops! we couldn't process image",
                               actionTitle: nil)
        case .unknownObjectType:
            let icon = #imageLiteral(resourceName: "failed_placeholder")
            return Placeholder(type: .default, icon: icon,
                               title: "Failed to identify image",
                               description: "Oops! That didn't work",
                               actionTitle: nil)
            
        case .none, .empty:
            return nil
        }
    }
}

class ReminderFormViewModel {
    var emojiType: Box<String?>
    var reminderTask: Box<String?>
    var dueDate: Box<String?>
    var notifyEnabled: Box<Bool>
    var taskType: Box<TaskType>
    var placeholderType: Box<ReminderFormPlaceholderType>
    
    var state: ReminderFormState?
    var visionWorker: VisionMLWorker?
    
    // MARK: - Initializer

    init(with state: ReminderFormState?) {
        self.state              = state
        let reminderItem        = state?.reminder
        let isNewReminder       = reminderItem == nil
        
        self.placeholderType    = Box(isNewReminder ? .empty : .none)
        self.emojiType          = Box(reminderItem?.taskType.emoji)
        self.reminderTask       = Box(reminderItem?.reminderTask)
        self.taskType           = Box(reminderItem?.taskType ?? .none)
        self.dueDate            = Box(reminderItem?.dueDateString)
        self.notifyEnabled      = Box(reminderItem?.notify ?? true)
    }
    
    // MARK: - Update Actions

    func loadReminderForm() {
        guard let state = state else {
            self.placeholderType.value = .empty
            return
        }
        
        if state.isNewReminder, let image = state.inputImage {
            createNewReminder(using: image)
        }
        else if let _ = state.reminderID {
            // fetch reminder from database and show it
            Log.debug("Needs implementation *pikachu face*")
        }
    }
    
    func createNewReminder(using image: UIImage) {
        guard  let visionWorker = try? VisionMLWorker(modelFile: .resnet50) else {
            self.placeholderType.value = .failedToProcess
            return
        }
        // present a loading screen
        self.placeholderType.value = .loading
        
        // prepare core ML request
        self.visionWorker = visionWorker
        self.visionWorker?.setupClassificationRequest()
        // process image async
        do {
            try self.visionWorker?.getClassifications(for: image) { (results) in
                DispatchQueue.main.async { [weak self] in
                    // lets take first result since we asked for only one
                    guard let result = results.first,
                        let reminderItem = ReminderItem(identifier: result.identifier) else {
                            // tell them to try again
                            self?.placeholderType.value = .unknownObjectType
                            return
                    }
                    // create a reminder Item
                    self?.showNewReminderItem(reminderItem)
                }
            }
        }
        catch {
            self.placeholderType.value = .failedToProcess
        }
    }
    
    func showNewReminderItem(_ reminderItem: ReminderItem) {
        // update state and discard image
        self.state?.reminder        = reminderItem
        // update view model properties
        self.placeholderType.value  = .none
        self.emojiType.value        = reminderItem.taskType.emoji
        self.reminderTask.value     = reminderItem.reminderTask
        self.taskType.value         = reminderItem.taskType
        self.dueDate.value          = reminderItem.dueDateString
        self.notifyEnabled.value    = reminderItem.notify
    }
    
    func updateReminderTask(_ task: String) {
        self.state?.reminder?.reminderTask  = task
        self.reminderTask.value             = task
    }
    
    // MARK: - Helper

    func reminderFormTitle() -> String {
        return state!.isNewReminder ? localized("New reminder") : localized("Edit reminder")
    }
}
