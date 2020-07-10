//
//  SuggestionsVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

protocol SuggestionsDelegate: class {
    func suggestions(_ suggestions: SuggestionsVC, didPick suggestions: String)
}

class SuggestionsVC: UITableViewController {
    
    var taskType: TaskType = .none {
        didSet {
            viewModel.loadSuggestions(for: taskType)
        }
    }
    weak var delegate: SuggestionsDelegate?
    
    private let viewModel = SuggestionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SuggestCell")
        tableView.tableFooterView   = UIView()
        tableView.backgroundColor   = AppTheme.background.color
        view.backgroundColor        = AppTheme.background.color
        loadSuggestions()
    }
    
    // MARK: - Initial setup
    
    func loadSuggestions() {
        viewModel.suggestions.bind { [weak self] (suggestions) in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return localized("Suggestions")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.suggestions.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestCell", for: indexPath)
        
        let suggestion = viewModel.suggestions.value[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = suggestion
        cell.textLabel?.textColor = AppTheme.darkText.color
        cell.backgroundColor = AppTheme.background.color
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = viewModel.suggestions.value[indexPath.row]
        delegate?.suggestions(self, didPick: suggestion)
    }
}

// MARK: - Factory Initializer
extension SuggestionsVC {
    class func newInstance() -> SuggestionsVC {
        let suggestionsVC = SuggestionsVC()
        return suggestionsVC
    }
}
