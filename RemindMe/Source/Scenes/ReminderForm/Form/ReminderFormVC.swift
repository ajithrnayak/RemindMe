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
    
    var image: UIImage?
    var reminder: ReminderItem?
    weak var delegate: ReminderFormDelegate?

    // MARK: - Properties (private)
    private var viewModel: ReminderFormViewModel?
    private var router: ReminderFormRouter?
    
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
    
    private let reminderDueDateView: DateInputFieldView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(DateInputFieldView())
    
    private let suggestionsVC = SuggestionsVC.newInstance()
    
    private let suggestionsContainerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
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
        setupDueDateView()
        setupSuggestionsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationActions()
        loadForm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reminderInputView.makeTextfieldActive(true)
    }
    
    // MARK: - Load Form
    private func loadForm() {
        var state: ReminderFormState?
        if let image = image {
            state = ReminderFormState(inputImage: image)
        } else if let reminder = reminder {
            state = ReminderFormState(reminder: reminder)
        }
        // setting title somewhere else behaves strangely so this code smell here
        //  self.title = state?.isNewReminder ? localized("New reminder") : localized("Edit reminder")
        self.viewModel = ReminderFormViewModel(with: state)
        self.viewModel?.loadReminderForm()
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
                           reminderInputView.heightAnchor.constraint(equalToConstant: 60.0)]
        constraints.forEach { $0.isActive = true }
    }
    
    private func setupDueDateView() {
        view.addSubview(reminderDueDateView)
        let constraints = [reminderDueDateView.topAnchor.constraint(equalTo: reminderInputView.bottomAnchor),
                           reminderDueDateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           reminderDueDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                           reminderDueDateView.heightAnchor.constraint(equalToConstant: 60.0)]
        constraints.forEach { $0.isActive = true }
    }
    
    private func setupSuggestionsView() {
        view.addSubview(suggestionsContainerView)
        let containerConstraints = [suggestionsContainerView.topAnchor.constraint(equalTo: reminderDueDateView.bottomAnchor,
                                                                                  constant: 16.0),
                                    suggestionsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                    suggestionsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                    suggestionsContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        containerConstraints.forEach { $0.isActive = true }
        
        suggestionsContainerView.addSubview(suggestionsVC.view)
        suggestionsVC.view.addConstraintsToMatch(superView: suggestionsContainerView)
    }
    
    private func configureNavigationActions() {
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
}

// MARK: - Factory Initializer
extension ReminderFormVC {
    class func newInstance() -> ReminderFormVC {
        let reminderFormVC = ReminderFormVC()
        return reminderFormVC
    }
}
