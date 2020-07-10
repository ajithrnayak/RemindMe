//
//  AppFonts.swift
//  Kipi
//
//  Created by Ajith R Nayak on 30/06/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import Foundation
import UIKit

struct AppFonts {
    
    enum NunitoFamily: String {
        case bold       = "Nunito-Bold"
        case regular    = "Nunito-Regular"
        
        func fontWithSize( _ size: CGFloat) -> UIFont {
            guard let customFont =  UIFont(name: rawValue, size: size) else {
                Log.fatal("""
                    Failed to load the "\(rawValue)" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    See https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app
                    """
                )
                fatalError()
            }
            return customFont
        }
    }
}
