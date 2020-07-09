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
            
        case .none:
            return nil
        }
    }
}

class ReminderFormViewModel {
    var emojiType: String?
    var reminderTask: String?
    var taskType: TaskType = .none
    var placeholderType: ReminderFormPlaceholderType = .none
    var title: String?
    
    let state: ReminderFormState?
    var visionWorker: VisionMLWorker?
    
    init(with state: ReminderFormState?) {
        self.state = state
    }
    
    func loadReminderForm() {
        self.placeholderType = .loading
        
        guard let state = state else {
            self.placeholderType = .none
            return
        }
        
        if state.isNewReminder, let image = state.inputImage {
            createNewReminder(using: image)
        }
        // else
        // process reminder
    }
    
    func createNewReminder(using image: UIImage) {
        guard  let visionWorker = try? VisionMLWorker(modelFile: .resnet50) else {
            self.placeholderType = .failedToProcess
            return
        }
        
        self.visionWorker = visionWorker
        self.visionWorker?.setupClassificationRequest()
        do {
            try self.visionWorker?.getClassifications(for: image, completionHandler: { (results) in
                // do ya thing
            })
        } catch {
            self.placeholderType = .failedToProcess
        }
    }
}
