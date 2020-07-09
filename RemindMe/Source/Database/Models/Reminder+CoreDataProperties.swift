//
//  Reminder+CoreDataProperties.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var isRemoved: Bool
    @NSManaged public var dueDate: Date?
    @NSManaged public var notify: Bool
    @NSManaged public var reminderID: String?
    @NSManaged public var completed: Bool
    @NSManaged public var task: String?
    @NSManaged public var taskType: String?

}
