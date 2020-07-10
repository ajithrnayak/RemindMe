//
//  AppTheme.swift
//  Kipi
//
//  Created by Ajith R Nayak on 27/06/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import Foundation
import UIKit

public enum AppTheme {
    case blue
    case pinkish
    case white
    case black
    case nickelBlack
    
    case background
    case backgroundVariant
    
    case darkText
    case lightText
    
    var color: UIColor {
        switch self {
        case .blue:
            return UIColor(hex: "01A4F6") ?? .blue
        case .pinkish:
             return UIColor(hex: "FF3E58") ?? .red
        case .black, .darkText:
            return UIColor(hex: "25292E") ?? .black
        case .nickelBlack, .backgroundVariant:
            return UIColor(hex: "2F3438") ?? .black
        case .white, .background:
            return UIColor(hex: "F4F4F9") ?? .white
        case .lightText:
            return UIColor(hex: "828282") ?? .gray
        }
    }
    
    var cgColor : CGColor {
        return self.color.cgColor
    }
}
