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
    func reminderFormDidSaveReminder()
}

class ReminderFormVC: UIViewController {
    
    var image: UIImage?
    var reminderID: String?
    weak var delegate: ReminderFormDelegate?
    
    // MARK: - Properties (private)
    private var viewModel: ReminderFormViewModel?
    private var router: ReminderFormRouter?
    
    lazy var backBarButtonItem = UIBarButtonItem(title: localized("Cancel"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(cancelReminderFormAction))
    
    lazy var doneBarButtonItem = UIBarButtonItem(title: localized("Done"),
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
    
    let reminderOptionsView = ReminderOptionsView()
    
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
        view.backgroundColor = AppTheme.background.color
        configureNavigationActions()
        
        suggestionsVC.delegate          = self
        reminderDueDateView.delegate    = self
        reminderInputView.delegate      = self
        reminderOptionsView.delegate    = self
        
        loadForm()
    }
    
    // MARK: - Load Form
    
    private func loadForm() {
        var state: ReminderFormState?
        if let image = image {
            state = ReminderFormState(inputImage: image)
        }
        else if let reminderID = reminderID {
            state = ReminderFormState(reminderID: reminderID)
        }
        // setting title somewhere else behaves strangely so this code smell here
        viewModel = ReminderFormViewModel(with: state)
        title = viewModel?.reminderFormTitle()
        // setup bindings
        renderContent()
        viewModel?.loadReminderForm()
    }
    
    // MARK: - Binding
    
    func renderContent() {
        viewModel?.placeholderType.bind(listener: { [weak self] (placeholderType) in
            self?.updatePlaceholder(placeholderType)
        })
        
        viewModel?.taskType.bind(listener: {[weak self] (taskType) in
            self?.suggestionsVC.taskType = taskType
            let showkeyboard = self?.viewModel?.showKeyboard ?? false
            self?.reminderInputView.makeTextfieldActive(showkeyboard)
        })
        
        viewModel?.emojiType.bind(listener: {[weak self] (emoji) in
            self?.reminderInputView.setEmoji(emoji)
        })
        
        viewModel?.reminderTask.bind(listener: {[weak self] (reminderTask) in
            self?.reminderInputView.setTextFieldInput(reminderTask)
        })
        
        viewModel?.dueDate.bind(listener: {[weak self] (dueDate) in
            self?.reminderDueDateView.setDateFieldInput(dueDate)
        })
        
        viewModel?.notifyEnabled.bind(listener: {[weak self] (notifyOn) in
            self?.reminderOptionsView.setNotifyButtonState(isSelectd: notifyOn)
        })
        
        viewModel?.status.bind(listener: { [weak self] (status) in
            self?.statusHandler(status)
        })
    }
    
    // MARK: - Actions
    
    @objc
    func cancelReminderFormAction() {
        delegate?.reminderFormDidRequestCancel()
    }
    
    @objc
    func saveReminderAction() {
        viewModel?.saveReminder()
    }
    
    // MARK: - Status handler
    private func statusHandler(_ status: ReminderFormStatus) {
        if status == .saveSuccess {
            delegate?.reminderFormDidSaveReminder()
        }
    }
    
}

// MARK: - Initial setup

extension ReminderFormVC {
    private func setupInputView() {
        view.addSubview(reminderInputView)
        reminderInputView.setupAccesoryView(reminderOptionsView)
        let constraints = [reminderInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           reminderInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           reminderInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                           reminderInputView.heightAnchor.constraint(equalToConstant: 60.0)]
        constraints.forEach { $0.isActive = true }
    }
    
    private func setupDueDateView() {
        view.addSubview(reminderDueDateView)
        reminderDueDateView.setupAccesoryView(reminderOptionsView)
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

// MARK: - Helpers

extension ReminderFormVC {
    
    func updatePlaceholder(_ placeholderType: ReminderFormPlaceholderType) {
        if placeholderType == .empty {
            showEmptyScreen(true)
            return
        }
        
        guard let placeholder = placeholderType.placeholder,
              placeholderType != .none else {
            showEmptyScreen(false)
            self.hidePlaceholder()
            return
        }
        
        self.showPlaceholder(placeholder)
    }
    
    func showEmptyScreen(_ isEmpty: Bool) {
        self.suggestionsContainerView.isHidden  = isEmpty
        self.reminderInputView.isHidden         = isEmpty
        self.reminderDueDateView.isHidden       = isEmpty
    }
}

// MARK: - SuggestionsDelegate
extension ReminderFormVC: SuggestionsDelegate {
    func suggestions(_ suggestions: SuggestionsVC, didPick suggestion: String) {
        viewModel?.updateReminderTask(suggestion)
    }
}

// MARK: - ReminderInputViewDelegate
extension ReminderFormVC: ReminderInputViewDelegate {
    func reminderInput(_ reminderInputView: ReminderInputView,
                       didChangeText text: String?) {
        viewModel?.setReminderTask(text)
    }
}

// MARK: - DateInputFieldViewDelegate
extension ReminderFormVC: DateInputFieldViewDelegate {
    func dateInputField(_ dateInputFielView: DateInputFieldView,
                        didChange date: Date) {
        viewModel?.setDueDate(date)
    }
}

extension ReminderFormVC: ReminderOptionsViewDelegate {
    func reminderOptions(_ reminderOptionsView: ReminderOptionsView,
                         didSelectNotify isSelected: Bool) {
        viewModel?.setNotifyFlag(isSelected)
    }
    
    func reminderOptionsDidSelectDone() {
        
    }
}

// MARK: - Factory Initializer
extension ReminderFormVC {
    class func newInstance() -> ReminderFormVC {
        let reminderFormVC = ReminderFormVC()
        return reminderFormVC
    }
}
