//
//  UIColor+Hex.swift
//  Kipi
//
//  Created by Ajith R Nayak on 27/06/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// Use to conveniently initialize a `UIColor` using hex code
    /// - Parameters:
    ///   - hex: A string of hex code in 6 character lenth format
    ///   - alpha: A value to set the opacity. default is 1
    public convenience init?(hex: String, alpha: CGFloat = 1) {
        
        // ensure correct character length
        guard hex.count == 6 else {
            return nil
        }
        
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        
        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }
        
        let r, g, b: CGFloat
        r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
        g = CGFloat((hexNumber & 0xFF00) >> 8) / 255.0
        b = CGFloat((hexNumber & 0xFF)) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
        return
    }
    
    
    /// Use to get a hex code as String for a UIColor instance
    /// - Returns: A hex code of color
    public func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255) << 16 | (Int)(g*255) << 8 | (Int)(b*255) << 0
        return String(format:"#%06x", rgb)
    }
}
