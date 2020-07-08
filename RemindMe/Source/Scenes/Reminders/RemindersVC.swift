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
        $0.backgroundColor = .white
        $0.setTitleColor(.systemPink, for: .normal)
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 42.0, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
        $0.addTarget(self, action: #selector(createReminderButtonAction), for: .touchUpInside)
        $0.fullyRounded(diameter: 60.0)
        return $0
    }(UIButton(type: .custom))
    
    // MARK: - Properties
    private var router: RemindersRouter!
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        setupRemindersList()
        setupCreateReminderButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RemindMe"
        configureScene()
    }
    
    // MARK: - Initial Configuration
    private func configureScene() {
        self.router = RemindersRouter(viewController: self)
    }
    
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
                           createReminderButton.heightAnchor.constraint(equalToConstant: 60.0),
                           createReminderButton.widthAnchor.constraint(equalToConstant: 60.0)]
        constraints.forEach { $0.isActive = true }
    }
    
    // MARK: - Actions
    @objc
    func createReminderButtonAction() {
        router.navigateToCamera()
    }

}

// MARK: - Factory Initializer
extension RemindersVC {
    class func newInstance() -> RemindersVC {
        let remindersVC = RemindersVC()
        return remindersVC
    }
}
