//
//  UIView+NSLayoutConstraint.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Add constraints to pin edges of the given superview
    /// - Parameter superView: The parent container view
    final func addConstraintsToMatch(superView: UIView) {
        let constraints = [topAnchor.constraint(equalTo: superView.topAnchor),
                           bottomAnchor.constraint(equalTo: superView.bottomAnchor),
                           leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                           trailingAnchor.constraint(equalTo: superView.trailingAnchor)]
        constraints.forEach { $0.isActive = true }
    }
}
