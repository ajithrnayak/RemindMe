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
    
    // MARK: - View Life cycle
    override func loadView() {
        super.loadView()
        setupCameraFeed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Initial Setup
    private func setupCameraFeed() {
        view.addSubview(cameraFeedView)
        cameraFeedView.addConstraintsToMatch(superView: view)
    }

}

// MARK: - Factory Initializer
extension CameraVC {
    class func newInstance() -> CameraVC {
        let cameraVC = CameraVC()
        return cameraVC
    }
}
