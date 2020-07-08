//
//  CameraVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class CameraVC: UIViewController {
    
    private let cameraFeedView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let captureButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
        $0.addTarget(self, action: #selector(captureAction), for: .touchUpInside)
        $0.fullyRounded(diameter: 60.0)
        return $0
    }(UIButton(type: .custom))
    
    lazy var cameraProvider = CameraProvider()
    
    // MARK: - View Life cycle
    override func loadView() {
        super.loadView()
        setupCameraFeed()
        setupCaptureButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showCameraFeed()
    }

    // MARK: - Initial Setup
    private func setupCameraFeed() {
        view.addSubview(cameraFeedView)
        cameraFeedView.addConstraintsToMatch(superView: view)
    }
    
    private func setupCaptureButton() {
        view.addSubview(captureButton)
        let constraints = [captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                        constant: -8.0),
                           captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                           captureButton.heightAnchor.constraint(equalToConstant: 60.0),
                           captureButton.widthAnchor.constraint(equalToConstant: 60.0)]
        constraints.forEach { $0.isActive = true }
    }
    
    private func showCameraFeed() {
        cameraProvider.configureCamera { [weak self] (previewLayer, error) in
            guard let previewLayer = previewLayer,
                let weakSelf = self else {
                    Log.error(error?.localizedDescription as Any)
                    return
            }
            
            weakSelf.cameraFeedView.layer.insertSublayer(previewLayer,
                                                         at: 0)
            previewLayer.frame = weakSelf.cameraFeedView.frame
        }
    }
    
    // MARK: - Actions
    @objc
    func captureAction() {
        print("Hello")
    }
}

// MARK: - Factory Initializer
extension CameraVC {
    class func newInstance() -> CameraVC {
        let cameraVC = CameraVC()
        return cameraVC
    }
}
