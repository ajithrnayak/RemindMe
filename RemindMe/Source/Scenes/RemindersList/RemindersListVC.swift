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
    
    private let viewModel = RemindersListViewModel()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints =  false
        loadReminders()
    }

    // MARK: - Load Reminders
    func loadReminders() {
        setupRenderUI()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReminderCell")
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

       override func tableView(_ tableView: UITableView,
                               cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
           // Configure the cell...
           let reminder = viewModel.reminder(at: indexPath)
           cell.textLabel?.text = reminder?.task
           cell.detailTextLabel?.text = reminder?.dueDateString
           cell.textLabel?.textColor = .black
           cell.backgroundColor = .white
           return cell
       }
}

// MARK: - Factory Initializer
extension RemindersListVC {
    class func newInstance() -> RemindersListVC {
        let remindersVC = RemindersListVC(style: .grouped)
        return remindersVC
    }
}
