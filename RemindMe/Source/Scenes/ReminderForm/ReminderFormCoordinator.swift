//
//  ReminderFormCoordinator.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit

class ReminderFormCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func showReminderForm() {
        let cameraVC = CameraVC.newInstance()
        cameraVC.delegate = self
        navigationController?.pushViewController(cameraVC,
                                                 animated: true)
    }
    
    func showNewReminderForm(using image: UIImage?) {
        let reminderFormVC = ReminderFormVC.newInstance()
        navigationController?.pushViewController(reminderFormVC,
                                                 animated: true)
    }
}

// MARK: - CameraDelegate
extension ReminderFormCoordinator: CameraDelegate {
    
    func cameraDidRequestCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func camera(_ cameraVC: CameraVC, didCapture image: UIImage?) {
        showNewReminderForm(using: image)
    }
}