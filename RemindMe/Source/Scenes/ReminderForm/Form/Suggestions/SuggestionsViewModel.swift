//
//  SuggestionsViewModel.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation

class SuggestionsViewModel {
    var suggestions: Box<[String]> = Box([])
    
    func loadSuggestions(for taskType: TaskType) {
        let suggestions = taskSuggestions(for: taskType)
        self.suggestions.value = suggestions
    }
    
    func taskSuggestions(for taskType: TaskType) -> [String] {
        switch taskType {
        case .vehicle:
            return ["Give it for Service" , "Wash" , "Change oil" , "Refuel" ]
        case .apparel:
            return ["Give it to laundry", "Wash", "Iron" , "Exchange/ Alter" , "Return"]
        case .book:
            return ["Return to library", "Order online", "Return to friend", "Enquire in library"]
        case .grocery:
            return ["Order Groceries", "Check on Amazon refund", "Collect myntra package"]
        case .code:
            return ["Commit everyday", "Watch a WWDC video"]
        case .none:
            return []
        }
    }
}
