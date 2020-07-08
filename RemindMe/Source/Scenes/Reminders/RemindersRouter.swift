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
    var formCoordinator: ReminderFormCoordinator!
    
    init(viewController: RemindersVC?) {
        self.viewController = viewController
    }
    
    func showNewReminderForm() {
        let navController = viewController?.navigationController
        formCoordinator = ReminderFormCoordinator(navigationController: navController)
        formCoordinator.showReminderForm()
    }
}
