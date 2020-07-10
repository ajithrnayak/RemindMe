//
//  ReminderCell.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 10/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit
protocol ReminderCellDelegate: class {
    func reminderCell(_ reminderCell: ReminderCell,
                      didCompleteReminderWith reminderID: String?)
}
class ReminderCell: UITableViewCell {
    
    var reminderID: String?
    weak var delegate: ReminderCellDelegate?
    
    let titleLabel: UILabel = {
        $0.textAlignment = .left
        $0.text = nil
        $0.font = AppFonts.NunitoFamily.bold.fontWithSize(18.0)
        $0.textColor = AppTheme.darkText.color
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let dueDateLabel: UILabel = {
        $0.textAlignment = .left
        $0.text = nil
        $0.font = AppFonts.NunitoFamily.regular.fontWithSize(16.0)
        $0.textColor = AppTheme.darkText.color
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let completeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = AppTheme.background.color
        $0.setTitle("  ", for: .normal)
        $0.addTarget(self, action: #selector(completeButtonAction), for: .touchUpInside)
        $0.layer.cornerRadius = 8.0
        $0.layer.borderWidth = 2.0
        $0.layer.borderColor = AppTheme.blue.cgColor
        return $0
    }(UIButton(type: .custom))
    
    // MARK: - initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AppTheme.background.color
        setupCompletedButton()
        setupContentLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - actions
    @objc
    func completeButtonAction() {
        delegate?.reminderCell(self, didCompleteReminderWith: reminderID)
    }
    
    func update(using reminderListItem: ReminderListItem) {
        self.reminderID         =  reminderListItem.id
        self.titleLabel.text    = reminderListItem.task
        self.dueDateLabel.text  = reminderListItem.dueDateString
    }
}

extension ReminderCell {
    func setupCompletedButton() {
        self.contentView.addSubview(completeButton)
        let constraints = [completeButton.heightAnchor.constraint(equalToConstant: 44.0),
                           completeButton.widthAnchor.constraint(equalToConstant: 44.0),
                           completeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                                   constant: 20.0),
                           completeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)]
        constraints.forEach { $0.isActive = true }
    }
    
    func setupContentLabels() {
        self.contentView.addSubview(titleLabel)
        let titleConstraints = [titleLabel.leadingAnchor.constraint(equalTo: completeButton.trailingAnchor,
                                                                    constant: 20.0),
                                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                                     constant: 20.0),
                                titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor)]
        titleConstraints.forEach { $0.isActive = true }
        
        self.contentView.addSubview(dueDateLabel)
        let dateConstraints = [dueDateLabel.leadingAnchor.constraint(equalTo: completeButton.trailingAnchor,
                                                                     constant: 20.0),
                               dueDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                                      constant: 20.0),
                               dueDateLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 4.0)]
        dateConstraints.forEach { $0.isActive = true }
    }
}
