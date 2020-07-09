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
        $0.titleLabel?.textAlignment    = .center
        $0.contentVerticalAlignment     = .center
        $0.contentHorizontalAlignment   = .center
        $0.addTarget(self, action: #selector(createReminderButtonAction), for: .touchUpInside)
        $0.fullyRounded(diameter: 60.0)
        return $0
    }(UIButton(type: .custom))
    
    // MARK: - Properties
    private var router: RemindersRouter!
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureScene()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScene() {
        self.router = RemindersRouter(viewController: self)
    }
    
    // MARK: - Actions
    @objc
    func createReminderButtonAction() {
        router.showNewReminderForm()
    }
}

// MARK: - View Life Cycle

extension RemindersVC {
    
    override func loadView() {
        super.loadView()
        setupRemindersList()
        setupCreateReminderButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RemindMe"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        remindersList.refreshReminders()
    }
}

// MARK: - Initial Configuration

extension RemindersVC {
    
    private func setupRemindersList() {
        view.addSubview(containerView)
        let constraints = [containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        constraints.forEach { $0.isActive = true }
        
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
}

// MARK: - Factory Initializer
extension RemindersVC {
    class func newInstance() -> RemindersVC {
        let remindersVC = RemindersVC()
        return remindersVC
    }
}
