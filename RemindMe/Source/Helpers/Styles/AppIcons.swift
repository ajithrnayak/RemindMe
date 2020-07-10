//
//  AppIcons.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

enum AppIcons {
    case createNew
    case notifyOn
    case notifyOff
    
    var image: UIImage? {
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        
        switch self {
        case .createNew:
            let boldSymbolImage = UIImage(systemName: "plus.circle.fill",
                                          withConfiguration: boldConfiguration)
            let plusImage = boldSymbolImage?.withTintColor(.white,
                                                           renderingMode: .alwaysOriginal)
            return plusImage
        case .notifyOn:
            let boldSymbolImage = UIImage(systemName: "bell.fill",
                                          withConfiguration: boldConfiguration)
            let bellImage = boldSymbolImage?.withTintColor(.white,
                                                           renderingMode: .alwaysOriginal)
            return bellImage
        case .notifyOff:
            let boldSymbolImage = UIImage(systemName: "bell.slash.fill",
                                          withConfiguration: boldConfiguration)
            let bellImage = boldSymbolImage?.withTintColor(.white,
                                                           renderingMode: .alwaysOriginal)
            return bellImage
        }
    }
}
