//
//  RemindersRouter.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

final class RemindersRouter {
    weak var viewController: RemindersVC?
    
    init(viewController: RemindersVC?) {
        self.viewController = viewController
    }
    
    func navigateToCamera() {
        let cameraVC = CameraVC.newInstance()
        viewController?.navigationController?.pushViewController(cameraVC, animated: true)
    }
    
    func showPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = viewController
        picker.sourceType = sourceType
        viewController?.present(picker, animated: true)
    }
}
