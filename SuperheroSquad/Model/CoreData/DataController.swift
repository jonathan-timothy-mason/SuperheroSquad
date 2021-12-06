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
class DataController: DataControllerProtocol {
    static var shared = DataController()
    let persistentContainer = NSPersistentContainer(name: "SuperheroSquad")
    
    /// Context for accessing data store for main thread.
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
           
    func loadDataStore() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
       
    func loadSquad() -> [SquadMember] {
        
        let fetchRequest = SquadMember.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "colName", ascending: true)]
        do {
            return try viewContext.fetch(fetchRequest)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveDataStore() {
        do {
            try viewContext.save()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func recruitToSquad(character: Character) {
        let squadMember = SquadMember(context: viewContext)
        squadMember.name = character.name
        squadMember.bio = character.bio
        squadMember.photo = character.bigPhoto?.pngData()
        saveDataStore()
    }
    
    func fireFromToSquad(squadMember: SquadMemberProtocol) {
        if let squadMember = squadMember as? SquadMember {
            viewContext.delete(squadMember)
            saveDataStore()
        }
    }
}
