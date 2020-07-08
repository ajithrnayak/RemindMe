//
//  PlaceholderStatus.swift
//  Kipi
//
//  Created by Ajith R Nayak on 27/06/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: PlaceholderStatus { }
extension UIView: PlaceholderStatus { }

/// default implementation of container in ViewControllers
extension PlaceholderStatus where Self: UIViewController {
    
    public var inView: PlaceholderViewContainer {
        return view
    }
}
/// default implementation of container in views
extension PlaceholderStatus where Self: UIView {
    
    public var inView: PlaceholderViewContainer {
        return self
    }
}

extension PlaceholderStatus where Self: UITableViewController {
    
    var inView: PlaceholderViewContainer {
        if let backgroundView = tableView.backgroundView {
            return backgroundView
        }
        return view
    }
}

// MARK: Conforming to protocol

extension UIView : PlaceholderViewContainer {
    public static let placeholderTag = 99
    
    public var placeholderContainerView: UIView? {
        get {
            return viewWithTag(UIView.placeholderTag)
        }
        set {
            viewWithTag(UIView.placeholderTag)?.removeFromSuperview()
            
            guard let view = newValue else { return }
            
            view.tag = UIView.placeholderTag
            addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(lessThanOrEqualToConstant: 320),
                view.widthAnchor.constraint(equalTo: self.widthAnchor),
                view.centerXAnchor.constraint(equalTo: centerXAnchor),
                view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15)
            ])
        }
    }
}
