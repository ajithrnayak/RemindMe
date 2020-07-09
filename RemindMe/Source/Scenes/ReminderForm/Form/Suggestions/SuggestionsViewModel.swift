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
        self.suggestions = Box(suggestions)
    }
    
    func taskSuggestions(for taskType: TaskType) -> [String] {
        switch taskType {
        case .vehicle:
            return []
        case .apparel:
            return []
        case .book:
            return []
        case .grocery:
            return []
        case .code:
            return []
        case .none:
            return []
        }
    }
}
