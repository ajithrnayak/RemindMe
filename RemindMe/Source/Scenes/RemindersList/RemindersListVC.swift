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
        
    }
    
    private var viewModel: RemindersListViewModel?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints =  false
        loadReminders()
    }

    // MARK: - Load Reminders
    func loadReminders() {
        self.viewModel = RemindersListViewModel()
        setupRenderUI()
        viewModel?.loadReminders()
    }
    
    // MARK: - Binding
    func setupRenderUI() {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}


// MARK: - Factory Initializer
extension RemindersListVC {
    class func newInstance() -> RemindersListVC {
        let remindersVC = RemindersListVC(style: .grouped)
        return remindersVC
    }
}
