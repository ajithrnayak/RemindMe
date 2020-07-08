//
//  NSLocalized+Global.swift
//  Kipi
//
//  Created by Ajith R Nayak on 01/07/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import Foundation

func localized(_ string: String, comment: String = "") -> String {
    return NSLocalizedString(string, comment: comment)
}
