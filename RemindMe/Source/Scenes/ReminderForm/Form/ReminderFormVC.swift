//
//  ReminderFormVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class ReminderFormVC: UIViewController {
    
    // MARK: - Properties
    private var router: ReminderFormRouter!
    
    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureScene()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScene() {
        self.router = ReminderFormRouter(viewController: self)
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}

// MARK: - Factory Initializer
extension ReminderFormVC {
    class func newInstance() -> ReminderFormVC {
        let reminderFormVC = ReminderFormVC()
        return reminderFormVC
    }
}
