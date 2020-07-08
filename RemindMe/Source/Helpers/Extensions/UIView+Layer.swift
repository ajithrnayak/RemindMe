//
//  UIView+Layer.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRounded(diameter: CGFloat,
                      borderColor: UIColor? = nil,
                      borderWidth: CGFloat? = nil) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            layer.borderColor = borderColor.cgColor
        }
    }
}
