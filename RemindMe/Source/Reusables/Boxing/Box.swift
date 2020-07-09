//
//  Box.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - Initializer
    
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Binding
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
