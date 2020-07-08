//
//  Placeholder.swift
//  Kipi
//
//  Created by Ajith R Nayak on 27/06/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import Foundation
import UIKit

public struct Placeholder {
    let type: PlaceholderType
    let icon: UIImage?
    let title: String?
    let description: String?
    let actionTitle: String?
    
    public init(type: PlaceholderType,
                icon: UIImage?,
                title: String?,
                description: String?,
                actionTitle: String?) {
        self.type = type
        self.icon = icon
        self.title = title
        self.description = description
        self.actionTitle = actionTitle
    }
}

extension Placeholder {
    public init(loadingMsg: String) {
        type        = .loading
        description = loadingMsg
        icon        = nil
        title       = nil
        actionTitle = nil
    }
}
