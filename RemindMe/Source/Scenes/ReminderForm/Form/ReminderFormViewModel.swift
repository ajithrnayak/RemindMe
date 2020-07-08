//
//  ReminderFormViewModel.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation

enum ReminderType {
    case vehicle
    case apparel
    case book
    case grocery
    case code
    
    var emoji: String {
        switch self {
        case .vehicle:
            return "🚘"
        case .apparel:
            return "👗"
        case .book:
            return "📚"
        case .grocery:
            return "🛍"
        case .code:
            return "👨‍💻"
        }
    }
}

class ReminderFormViewModel {
    var state: ReminderFormState?
}
