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
    
    var image: UIImage? {
        switch self {
        case .createNew:
            let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
            let boldSymbolImage = UIImage(systemName: "plus.circle.fill",
                                          withConfiguration: boldConfiguration)
            let plusImage = boldSymbolImage?.withTintColor(.white,
                                                           renderingMode: .alwaysOriginal)
            return plusImage
        }
    }
}
