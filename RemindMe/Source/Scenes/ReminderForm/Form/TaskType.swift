//
//  TaskType.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation

enum TaskType: String {
    case vehicle
    case apparel
    case book
    case grocery
    case code
    case none
    
    init?(objectType: String) {
        let objectMap = ["car": "vehicle", "bike": "vehicle", "Bicycle": "vehicle", "truck": "vehicle",
                         "jeans": "apparel","dress": "apparel","shirt": "apparel","tshirt": "apparel",
                         "tomato": "grocery","potato": "grocery","onion": "grocery","banana": "grocery",
                         "oxford dictionary": "book", "merriam webster": "book", "book": "book"]
        let type = objectMap[objectType] ?? "none"
        self.init(rawValue: type)
    }
    
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
        case .none:
            return ""
        }
    }
}
