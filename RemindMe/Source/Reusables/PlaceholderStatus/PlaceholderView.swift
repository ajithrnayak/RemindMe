//
//  PlaceholderView.swift
//  Kipi
//
//  Created by Ajith R Nayak on 27/06/20.
//  Copyright © 2020 Blacktea Studio. All rights reserved.
//

import UIKit

class PlaceholderView : UIStackView {
    
    /// An optional empty placeholder icon
    var iconImageVIew: UIImageView = {
        $0.contentMode = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    var titleLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 20.0,
                                    weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.minimumScaleFactor = 0.5
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    var activityIndicatorView: UIActivityIndicatorView = {
        $0.color = UIColor.purple
        $0.hidesWhenStopped = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView(style: .large))
    
    var descriptionLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16.0,
                                    weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 3
        $0.minimumScaleFactor = 0.5
        $0.textColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    var actionButton: UIButton = {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16.0,
                                                weight: .bold)
        $0.addTarget(self,
                     action: #selector(onButtonAction(_:)),
                     for: .touchUpInside)
        $0.layer.cornerRadius = 4.0
        $0.backgroundColor = UIColor(red: 0.05098039216, green: 0.3725490196, blue: 0.7647058824, alpha: 1.0)
        $0.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 30.0,
                                            bottom: 10.0, right: 30.0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .custom))
    
    public var onAction : (() -> Void)?
    
    // MARK: Actions
    
    @objc
    func onButtonAction(_ sender: UIButton) {
        onAction?()
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderLayout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        renderLayout()
    }
    
    private func renderLayout() {
        self.axis           = .vertical
        self.distribution   = .fill
        self.spacing        = 12.0
        self.alignment      = .center
        
        //Stack View to match design requirement
        let childStackView1   = UIStackView()
        childStackView1.axis  = .vertical
        childStackView1.distribution  = .fill
        childStackView1.alignment = .center
        childStackView1.spacing   = 20.0
        
        childStackView1.addArrangedSubview(iconImageVIew)
        childStackView1.addArrangedSubview(titleLabel)
        childStackView1.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(childStackView1)
        // add activity indicator without a child stackview
        self.addArrangedSubview(activityIndicatorView)
        //Stack View to match design requirement
        let childStackView2   = UIStackView()
        childStackView2.axis  = .vertical
        childStackView2.distribution  = .fill
        childStackView2.alignment = .center
        childStackView2.spacing   = 30.0
        
        childStackView2.addArrangedSubview(descriptionLabel)
        childStackView2.addArrangedSubview(actionButton)
        childStackView2.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(childStackView2)
    }
}

extension PlaceholderView : PlaceholderStatusView {
    public var placeholderAction: UIButton {
        return actionButton
    }
    
    public var placeholderDescription: UILabel {
        return descriptionLabel
    }
    
    public var placeholderIndicator: UIActivityIndicatorView {
        return activityIndicatorView
    }
    
    public var placeholderTitle: UILabel {
        return titleLabel
    }
    
    public var placeholderIcon: UIImageView {
        return iconImageVIew
    }
    
    var view: UIView {
        return self
    }
}
