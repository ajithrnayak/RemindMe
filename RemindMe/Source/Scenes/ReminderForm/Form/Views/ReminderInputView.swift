//
//  ReminderInputView.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class ReminderInputView: UIView {
    
    func makeTextfieldActive(_ flag: Bool) {
        if flag {
            self.inputField.becomeFirstResponder()
        } else {
            self.inputField.resignFirstResponder()
        }
    }
    
    func setEmoji(_ emoji: String?) {
        self.emojiLabel.text = emoji
    }
    
    func setTextFieldInput(_ text: String?) {
        self.inputField.text = text
    }
    
    // MARK: - private properties
    
    private let emojiLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 22.0)
        return $0
    }(UILabel())
    
    private let inputField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle          = .none
        $0.font                 = UIFont.systemFont(ofSize: 16.0)
        $0.autocorrectionType   = UITextAutocorrectionType.no
        $0.keyboardType         = UIKeyboardType.default
        $0.returnKeyType        = .done
        $0.clearButtonMode      = .whileEditing
        $0.contentVerticalAlignment = .center
        return $0
    }(UITextField())
    
    let bottomBorderView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .separator
        return $0
    }(UIView())
    
    let reminderOptionsView = ReminderOptionsView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInputView()
        setupBottomBorder()
        setupAccesoryView()
        backgroundColor = .white
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    // MARK: - Setup
    
    private func setupAccesoryView() {
        let width = self.frame.width
        self.reminderOptionsView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 50.0)
        inputField.inputAccessoryView = self.reminderOptionsView
    }
    
    private func setupInputView() {
        addSubview(emojiLabel)
        let labelConstraints = [emojiLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                    constant: 16.0),
                                emojiLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                emojiLabel.heightAnchor.constraint(equalToConstant: 50.0),
                                emojiLabel.widthAnchor.constraint(equalToConstant: 80.0)]
        labelConstraints.forEach({ $0.isActive = true })
        
        addSubview(inputField)
        inputField.delegate = self
        let textFieldConstraints = [inputField.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor,
                                                                        constant: 8.0),
                                    inputField.heightAnchor.constraint(equalToConstant: 50.0),
                                    inputField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                    inputField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                         constant: -16.0)]
        textFieldConstraints.forEach({ $0.isActive = true })
    }
    
    private func setupBottomBorder() {
        addSubview(bottomBorderView)
        let borderConstraints = [bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                           constant: 20.0),
                                 bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                            constant: -20.0),
                                 bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                 bottomBorderView.heightAnchor.constraint(equalToConstant: 1.0)]
        borderConstraints.forEach({ $0.isActive = true })
    }
    
}

// MARK: - UITextFieldDelegate
extension ReminderInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
