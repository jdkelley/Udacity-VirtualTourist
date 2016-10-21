//
//  CoreDataStack.swift
//
//
//  Created by Fernando Rodríguez Romero on 21/02/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import CoreData

// MARK: - CoreDataStack

struct CoreDataStack {
    
    // MARK: Properties
    
    private let model: NSManagedObjectModel
    fileprivate let coordinator: NSPersistentStoreCoordinator
    private let modelURL: URL
    fileprivate let dbURL: URL
    let context: NSManagedObjectContext
    
    // MARK: Initializers
    
    init?(modelName: String) {
        
        // Assumes the model is in the main bundle
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            print("Unable to find \(modelName)in the main bundle")
            return nil
        }
        self.modelURL = modelURL
        
        // Try to create the model from the URL
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            print("unable to create a model from \(modelURL)")
            return nil
        }
        self.model = model
        
        // Create the store coordinator
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        // create a context and add connect it to the coordinator
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        
        // Add a SQLite store located in the documents folder
        let fm = FileManager.default
        
        guard let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Unable to reach the documents folder")
            return nil
        }
        
        self.dbURL = docUrl.appendingPathComponent("model.sqlite")
        //self.dbURL = docUrl.URLByAppendingPathComponent("model.sqlite")!
        
        // Options for migration
        let options = [NSInferMappingModelAutomaticallyOption : true, NSMigratePersistentStoresAutomaticallyOption : true]
        
        do {
            try addStoreCoordinator(storeType: NSSQLiteStoreType, configuration: nil, storeURL: dbURL as NSURL, options: options as [NSObject : AnyObject]?)
        } catch {
            print("unable to add store at \(dbURL)")
        }
    }
    
    // MARK: Utils
    
    func addStoreCoordinator(storeType: String, configuration: String?, storeURL: NSURL, options : [NSObject : AnyObject]?) throws {
//        try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: dbURL as URL, options: nil)
//        
        
        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbURL, options: nil)
    }
}


// MARK: - CoreDataStack (Removing Data)

extension CoreDataStack  {
    
    func dropAllData() throws {
        // delete all the objects in the db. This won't delete the files, it will
        // just leave empty tables.
//        try coordinator.destroyPersistentStore(at: dbURL, ofType:NSSQLiteStoreType , options: nil)
//        try addStoreCoordinator(storeType: NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: nil)
//        
        try coordinator.destroyPersistentStore(at: dbURL, ofType: NSSQLiteStoreType, options: nil)
        try addStoreCoordinator(storeType: NSSQLiteStoreType, configuration: nil, storeURL: dbURL as NSURL, options: nil)
    }
}

// MARK: - CoreDataStack (Save)

extension CoreDataStack {
    
    func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func autoSave(delayInSeconds: Int) {
        
        if delayInSeconds > 0 {
            do {
                try saveContext()
                print("Autosaving")
            } catch {
                print("Error while autosaving")
            }
            
            let delayInNanoSeconds = UInt64(delayInSeconds) * NSEC_PER_SEC
            let time = DispatchTime.now() + Double(Int64(delayInNanoSeconds))
//            let time = DispatchTime.now(dispatch_time_t(DispatchTime.now), Int64(delayInNanoSeconds))
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.autoSave(delayInSeconds: delayInSeconds)
            }
            
//            dispatch_after(time, dispatch_get_main_queue()) {
//                self.autoSave(delayInSeconds)
//            }
        }
    }
}
