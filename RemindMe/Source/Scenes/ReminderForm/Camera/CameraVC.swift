//
//  CameraVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

protocol CameraDelegate: class {
    func cameraDidRequestCancel()
    func camera(_ cameraVC: CameraVC, didCapture image: UIImage?)
}

class CameraVC: UIViewController {
    
    weak var delegate: CameraDelegate?
    
    // MARK: - View Properties
    
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
    
    private let backBarButtonItem = UIBarButtonItem(title: localized("Cancel"),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(cancelCameraAction))
    
    let photoPicker = UIImagePickerController()
    
    // MARK: - View Life cycle
    
    override func loadView() {
        super.loadView()
        setupCameraFeed()
        setupImagePicker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLeftBarButton(backBarButtonItem, animated: true)
    }
    
    // MARK: - Initial Setup
    private func setupCameraFeed() {
        view.addSubview(cameraFeedView)
        cameraFeedView.addConstraintsToMatch(superView: view)
    }
    
    private func setupImagePicker() {
        photoPicker.delegate    = self
        photoPicker.sourceType  = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        photoPicker.view.translatesAutoresizingMaskIntoConstraints = false
        cameraFeedView.addSubview(photoPicker.view)
        photoPicker.view.addConstraintsToMatch(superView: cameraFeedView)
    }
    
    /*
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
     */
    
    
    // MARK: - Actions
    @objc
    func captureAction() {
        print("Hello")
    }
    
    @objc
    func cancelCameraAction() {
        delegate?.cameraDidRequestCancel()
    }
}

// MARK: - Handling Image Picker Selection
extension CameraVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cameraDidRequestCancel()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        delegate?.camera(self, didCapture: image)
    }
}

// MARK: - Factory Initializer
extension CameraVC {
    class func newInstance() -> CameraVC {
        let cameraVC = CameraVC()
        return cameraVC
    }
}
