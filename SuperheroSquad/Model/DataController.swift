//
//  DataController.swift
//  SuperHeroSquad
//
//  Created by Jonathan Mason on 04/12/2021.
//

import Foundation
import CoreData

/// Helper for using data store.
/// Based on "What Is a Singleton and How To Create One In Swift" by Bart Jacobs:
/// https://cocoacasts.com/what-is-a-singleton-and-how-to-create-one-in-swift/
class DataController {
    static let shared = DataController()
    let persistentContainer = NSPersistentContainer(name: "SuperheroSquad")
    
    /// Context for accessing data store for main thread.
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
           
    /// Load data store.
    func loadDataStore() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
       
    /// Load squad from data store.
    func loadSquad() -> [SquadMember] {
        
        let fetchRequest = SquadMember.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            return try viewContext.fetch(fetchRequest)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Save data store.
    func saveDataStore() {
        do {
            try viewContext.save()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
}
