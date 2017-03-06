//
//  DataStore.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Tameika Lawrence. All rights reserved.
//

import Foundation
import CoreData


final class DataStore {
    
    var adviceArray = [Advice]()
    var favorites = [Advice]()
    
    static let sharedInstance = DataStore()
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "adviceApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchFavorites() {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Advice>(entityName: "Advice")
        
        let predicate = NSPredicate(format: "isFavorited == %@", NSNumber(booleanLiteral: true))
        
        fetchRequest.predicate = predicate
        
        do {
            
            favorites = try context.fetch(fetchRequest)
            
        } catch {
            
            print("Can't find any favorited.")
            
        }
        
    
    }
    
    func fetchData() {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Advice>(entityName: "Advice")
        
        do {
            
            adviceArray = try context.fetch(fetchRequest)
            
        } catch {
            
            print("Advice not fetched.")
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
