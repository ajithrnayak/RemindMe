//
//  SectionHeaderView.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 10/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
    
    func setHeaderTitle(_ title: String?) {
        self.titleLabel.text = title
    }
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = AppFonts.NunitoFamily.bold.fontWithSize(22.0)
        $0.text = ""
        $0.textColor = .black
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppTheme.background.color
        setupTitleLabel()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    // MARK: - setup
    private func setupTitleLabel() {
        addSubview(titleLabel)
        let titleConstraints = [titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                    constant: 20.0),
                                titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
        titleConstraints.forEach({ $0.isActive = true })
    }
}
