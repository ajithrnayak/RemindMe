//
//  PlaceholderStatus.swift
//  Kipi
//
//  Created by Ajith R Nayak on 27/06/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import Foundation
import UIKit

/// Different types of Placeholder states
///
/// - loading:  Use in case of async requests
/// - error:    Use to show error & retry an action
/// - empty:    Use to indicate no data yet & optional action for use cases such as Add, Create
public enum PlaceholderType {
    case loading
    case `default`
}

public typealias PlaceholderActionBlock = (() -> Void)

/// A protocol that handles Placeholders of kind PlaceholderStatusType in ViewControllers and Views
public protocol PlaceholderStatus {
    var placeholderView: PlaceholderStatusView? { get }
    var inView: PlaceholderViewContainer { get }
    
    func showPlaceholder(_ placeholder: Placeholder, action: PlaceholderActionBlock?)
    func hidePlaceholder()
}

/// Placeholder view must conform to this protocol.
public protocol PlaceholderStatusView: class {
    var view : UIView { get }
    var placeholderIcon: UIImageView { get }
    var placeholderTitle: UILabel { get }
    var placeholderIndicator: UIActivityIndicatorView { get }
    var placeholderDescription: UILabel { get }
    var placeholderAction: UIButton { get }
    var onAction: (() -> Void)? { get set }
}

/// A protocol to show Placeholder on which View
public protocol PlaceholderViewContainer: class {
    var placeholderContainerView: UIView? { get set }
}

// MARK: Default implementations

extension PlaceholderStatus {
    public var placeholderView : PlaceholderStatusView? {
        return PlaceholderView() as PlaceholderStatusView
    }
    
    public func hidePlaceholder() {
        inView.placeholderContainerView?.removeFromSuperview()
        inView.placeholderContainerView = nil
    }
    
    public func showPlaceholder(_ placeholder: Placeholder,
                                action: PlaceholderActionBlock? = nil) {
        guard let placeholderView = placeholderView else {
            return
        }
        
        inView.placeholderContainerView = placeholderView.view
        let statusType                  = placeholder.type
        
        switch statusType {
        case .default:
            //update view
            placeholderView.placeholderIcon.image       = placeholder.icon
            placeholderView.placeholderTitle.text       = placeholder.title
            placeholderView.placeholderDescription.text = placeholder.description
            
            //unhide empty state needful elements
            placeholderView.placeholderIcon.isHidden        = false
            placeholderView.placeholderTitle.isHidden       = false
            placeholderView.placeholderDescription.isHidden = false
            
            //activity indicator never shown
            placeholderView.placeholderIndicator.stopAnimating()
            placeholderView.placeholderIndicator.isHidden = true
            
            //if action title, then show action..
            if let actionTitle = placeholder.actionTitle, let action = action {
                placeholderView.placeholderAction.setTitle(actionTitle, for: .normal)
                placeholderView.onAction                    = action
                placeholderView.placeholderAction.isHidden   = false
            } else {
                placeholderView.onAction                    = nil
                placeholderView.placeholderAction.isHidden   = true
            }
            
            placeholderView.view.setNeedsDisplay()
            
        case .loading:
            placeholderView.onAction                    = nil
            placeholderView.placeholderAction.isHidden   = true
            
            placeholderView.placeholderIcon.isHidden    = true
            placeholderView.placeholderTitle.isHidden   = true
            
            placeholderView.placeholderDescription.isHidden = false
            placeholderView.placeholderDescription.text     = placeholder.description
            
            placeholderView.placeholderIndicator.startAnimating()
            placeholderView.placeholderIndicator.isHidden = false
            
            placeholderView.view.setNeedsLayout()
        }
    }
}
