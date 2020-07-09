//
//  ReminderOptionsView.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

protocol ReminderOptionsViewDelegate: class {
    func reminderOptions(_ reminderOptionsView: ReminderOptionsView,
                         didSelectNotify isSelected: Bool)
    func reminderOptionsDidSelectDone()
}

class ReminderOptionsView: UIView {
    
    weak var delegate: ReminderOptionsViewDelegate?
    
    let notifyButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(AppIcons.notifyOn.image, for: .selected)
        $0.setImage(AppIcons.notifyOff.image, for: .normal)
        $0.addTarget(self,
                     action: #selector(notifyButtonAction),
                     for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    let doneButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(localized("Done"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        $0.addTarget(self,
                     action: #selector(doneButtonAction),
                     for: .touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    // MARK: - Actions
    
    @objc
    func notifyButtonAction() {
        delegate?.reminderOptions(self, didSelectNotify: notifyButton.isSelected)
    }
    
    @objc
    func doneButtonAction() {
        delegate?.reminderOptionsDidSelectDone()
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOptionsView()
        setupTopBorder()
        backgroundColor = .white
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    // MARK: - setup

    private func setupOptionsView() {
        addSubview(notifyButton)
        let constraints = [notifyButton.heightAnchor.constraint(equalToConstant: 44.0),
                           notifyButton.widthAnchor.constraint(equalToConstant: 44.0),
                           notifyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
                           notifyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
        constraints.forEach({ $0.isActive = true })
        
        addSubview(doneButton)
        let doneConstraints = [doneButton.heightAnchor.constraint(equalToConstant: 44.0),
                           doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
                           doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
        doneConstraints.forEach({ $0.isActive = true })
    }
    
    private func setupTopBorder() {
//         addSubview(bottomBorderView)
//         let borderConstraints = [bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
//                                                                            constant: 16.0),
//                                  bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
//                                                                             constant: -16.0),
//                                  bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//                                  bottomBorderView.heightAnchor.constraint(equalToConstant: 1.0)]
//         borderConstraints.forEach({ $0.isActive = true })
     }
}
