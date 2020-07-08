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
    
    private let createReminderButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBlue
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let boldSymbolImage = UIImage(systemName: "plus.circle.fil",
                                      withConfiguration: boldConfiguration)
        $0.imageView?.image = boldSymbolImage?.withTintColor(.cyan,
                                                             renderingMode: .alwaysOriginal)
        return $0
    }(UIButton(type: .custom))
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        setupRemindersList()
        setupCreateReminderButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RemindMe"
    }
    
    // MARK: - Initial Configuration
    private func setupRemindersList() {
        view.addSubview(containerView)
        containerView.addConstraintsToMatch(superView: view)
        
        containerView.addSubview(remindersList.view)
        remindersList.view.addConstraintsToMatch(superView: containerView)
    }
    
    private func setupCreateReminderButton() {
        view.addSubview(createReminderButton)
        let constraints = [createReminderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                        constant: -8.0),
                           createReminderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                          constant: -16.0),
                           createReminderButton.heightAnchor.constraint(equalToConstant: 50.0),
                           createReminderButton.widthAnchor.constraint(equalToConstant: 50.0)]
        constraints.forEach { $0.isActive = true }
    }
}

// MARK: - Factory Initializer
extension RemindersVC {
    class func newInstance() -> RemindersVC {
        let remindersVC = RemindersVC()
        return remindersVC
    }
}
