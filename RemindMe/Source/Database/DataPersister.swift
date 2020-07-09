//
//  DataPersister.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 09/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import CoreData

class DataPersister {
    /// Shared access for data persistence
    static let shared: DataPersister = DataPersister()
    private let defaultFetchBatchSize = 50
    
    // MARK: - initializer
    private init() { }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RemindMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            Log.info("Loading persistent store \(storeDescription)")
            if let error = error as NSError? {
                Log.fatal("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// Shortcut to access main managed object context
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var newBackgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    var managedObjectModel: NSManagedObjectModel {
        return persistentContainer.managedObjectModel
    }

       // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                let nserror = error as NSError
                Log.fatal("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
