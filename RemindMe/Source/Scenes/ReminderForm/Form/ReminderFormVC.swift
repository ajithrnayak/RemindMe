//
//  ReminderFormVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

protocol ReminderFormDelegate: class {
    func reminderFormDidRequestCancel()
}

class ReminderFormVC: UIViewController {
    
    // MARK: - Properties
    weak var delegate: ReminderFormDelegate?
    
    private var router: ReminderFormRouter!
    
    private let backBarButtonItem = UIBarButtonItem(title: localized("Cancel"),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(cancelReminderFormAction))
    
    private let doneBarButtonItem = UIBarButtonItem(title: localized("Done"),
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(saveReminderAction))
    
    private let reminderInputView: ReminderInputView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ReminderInputView())
    
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
    override func loadView() {
        super.loadView()
        setupInputView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    @objc
    func cancelReminderFormAction() {
        delegate?.reminderFormDidRequestCancel()
    }
    
    @objc
    func saveReminderAction() {
    }
    
}

// MARK: - Initial setup

extension ReminderFormVC {
    private func setupInputView() {
        view.addSubview(reminderInputView)
        let constraints = [reminderInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           reminderInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           reminderInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                           reminderInputView.heightAnchor.constraint(equalToConstant: 80.0)]
        constraints.forEach { $0.isActive = true }
    }
}

// MARK: - Factory Initializer
extension ReminderFormVC {
    class func newInstance() -> ReminderFormVC {
        let reminderFormVC = ReminderFormVC()
        return reminderFormVC
    }
}
