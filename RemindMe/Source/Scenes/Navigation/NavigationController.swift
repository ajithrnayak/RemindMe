//
//  NavigationController.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.background.color
        navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Factory Initializer
extension NavigationController {
    class func newInstance(using rootVC: UIViewController) -> NavigationController {
        let navController = NavigationController(rootViewController: rootVC)
        return navController
    }
}
