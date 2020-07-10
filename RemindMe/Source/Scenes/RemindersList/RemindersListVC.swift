//
//  RemindersListVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class RemindersListVC: UITableViewController {

    func refreshReminders() {
        viewModel.loadReminders()
    }
    
    func searchReminder(for searchString: String?) {
        viewModel.searchReminder(for: searchString)
    }
    
    private let viewModel = RemindersListViewModel()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.background.color
        view.translatesAutoresizingMaskIntoConstraints =  false
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        loadReminders()
    }

    // MARK: - Load Reminders
    func loadReminders() {
        setupRenderUI()
        tableView.register(ReminderCell.self, forCellReuseIdentifier: "ReminderCell")
    }
    
    // MARK: - Binding
    func setupRenderUI() {
        viewModel.reminders.bind {[weak self] (reminders) in
            self?.tableView.reloadData()
        }
        
        viewModel.placeholder.bind {[weak self] (placeholderType) in
            self?.updatePlaceholder(placeholderType)
        }
    }
}

extension RemindersListVC {
    private func updatePlaceholder(_ placeholderType: RemindersListPlaceholderType) {
        switch placeholderType {
        case .empty, .loading, .fetchFailed:
            if let placeholder = placeholderType.placeholder {
                tableView.showPlaceholder(placeholder)
                break
            }
            fallthrough
        case .none:
            tableView.hidePlaceholder()
        }
    }
}

// MARK: - Table view data source

extension RemindersListVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView()
        view.setHeaderTitle(viewModel.sectionTitle(for: section))
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell",
                                                       for: indexPath) as? ReminderCell,
            let reminder = viewModel.reminder(at: indexPath) else {
                return UITableViewCell()
        }
        // Configure the cell...
        cell.update(using: reminder)
        cell.delegate = self
        cell.selectionStyle = .none
        cell.backgroundColor = AppTheme.background.color
        return cell
    }
}

// MARK: - ReminderCellDelegate
extension RemindersListVC: ReminderCellDelegate {
    func reminderCell(_ reminderCell: ReminderCell,
                      didCompleteReminderWith reminderID: String?) {
        if let reminderID = reminderID {
            viewModel.completeReminder(with: reminderID)
        }
    }
}

// MARK: - Factory Initializer
extension RemindersListVC {
    class func newInstance() -> RemindersListVC {
        let remindersVC = RemindersListVC(style: .grouped)
        return remindersVC
    }
}
