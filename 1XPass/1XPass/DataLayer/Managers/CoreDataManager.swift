//
//  CoreDataManager.swift
//  1XPass
//
//  Created by Vlad on 02.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "_XPass")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func savePassword(name: String, value : String) {
        
        
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Password",
                                                in: managedContext)!
        
        let password = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
        
        
        password.setValue(name, forKeyPath: "name")
        password.setValue(value, forKeyPath: "value")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func delete(person : Password){
        
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        managedContext.delete(person)
      
        do {
            try managedContext.save()
        } catch {
             print(error)
        }
    }
    
    func fetchAllPasswords() -> [Password]?{
        
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Password")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [Password]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}

