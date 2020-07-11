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
    
    func showNewReminderForm(using image: UIImage?) {
        let reminderFormVC      = ReminderFormVC.newInstance()
        reminderFormVC.image    = image
        reminderFormVC.delegate = viewController
        viewController?.navigationController?.pushViewController(reminderFormVC,
                                                                animated: true)
    }
    
    func popToRootViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
