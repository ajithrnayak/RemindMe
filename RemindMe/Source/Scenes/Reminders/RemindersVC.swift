//
//  RemindersVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class RemindersVC: UIViewController {

    private let remindersList = RemindersListVC.newInstance()
    private let containerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    // MARK: - View Life Cycle

    override func loadView() {
        super.loadView()
        setupRemindersList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        title = "RemindMe"
    }

    // MARK: - Initial Configuration
    private func setupRemindersList() {
        view.addSubview(containerView)
        containerView.addConstraintsToMatch(superView: view)
        
        containerView.addSubview(remindersList.view)
        remindersList.view.addConstraintsToMatch(superView: containerView)
    }
}

// MARK: - Factory Initializer
extension RemindersVC {
    class func newInstance() -> RemindersVC {
        let remindersVC = RemindersVC()
        return remindersVC
    }
}
