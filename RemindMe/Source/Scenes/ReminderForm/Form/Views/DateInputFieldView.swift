//
//  DateInputFieldView.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

protocol DateInputFieldViewDelegate: class{
    func dateInputField(_ dateInputFielView: DateInputFieldView,
                        didChange date: Date)
}

class DateInputFieldView: UIView {
    
    weak var delegate: DateInputFieldViewDelegate?
    
    func makeDatefieldActive(_ flag: Bool) {
         if flag {
             self.dateTextField.becomeFirstResponder()
         } else {
             self.dateTextField.resignFirstResponder()
         }
     }
     
     func setDateFieldInput(_ text: String?) {
         self.dateTextField.text = text
     }
    
    func setupAccesoryView(_ view: UIView) {
        let width = self.frame.width
        view.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 50.0)
        dateTextField.inputAccessoryView = view
    }
    
    // MARK: - properties

    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16.0)
        $0.text = localized("Due Date")
        $0.textColor = .black
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    private let dateTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle          = .none
        $0.font                 = UIFont.systemFont(ofSize: 16.0)
        $0.textColor            = .black
        $0.contentVerticalAlignment = .center
        $0.placeholder          = localized("Enter a due date")
        return $0
    }(UITextField())
    
    let datePicker: UIDatePicker = {
        $0.datePickerMode = .dateAndTime
        $0.addTarget(self, action: #selector(datePickerValueChanged),
                     for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    let bottomBorderView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .separator
        return $0
    }(UIView())
        
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppTheme.background.color
        setupDateFieldView()
        setupDateFieldInputView()
        setupBottomBorder()
        
        dateTextField.delegate = self
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    // MARK: - actions
    @objc
    func datePickerValueChanged() {
        delegate?.dateInputField(self, didChange: datePicker.date)
    }
    
    // MARK: - Setup
    func setupDateFieldView() {
        addSubview(titleLabel)
        let titleConstraints = [titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                    constant: 20.0),
                                titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
        titleConstraints.forEach({ $0.isActive = true })
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        addSubview(dateTextField)
        let dateFieldConstraints = [dateTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                                           constant: 16.0),
                                    dateTextField.heightAnchor.constraint(equalToConstant: 50.0),
                                    dateTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                    dateTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                            constant: -16.0)]
        dateFieldConstraints.forEach({ $0.isActive = true })
        dateTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupDateFieldInputView() {
        dateTextField.inputView = datePicker
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

extension DateInputFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let dateNow = Date()
        self.datePicker.minimumDate = dateNow
        self.datePicker.date = dateNow
    }
}
