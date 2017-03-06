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
        let container = NSPersistentContainer(name: "adviceApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
