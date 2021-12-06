//
//  DataControllerProtocol.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 06/12/2021.
//

import Foundation

/// Protocol to be implemented by DataController.
/// - Note: Protocol provides main access to DataContoller for app. This allows TestDataContoller to be injected during testing.
protocol DataControllerProtocol {
    /// Load data store.
    func loadDataStore()
       
    /// Load squad from data store.
    func loadSquad() -> [SquadMember]
    
    /// Save data store.
    func saveDataStore()
    
    /// Create new squad member from supplied character and recruit to squad, saving to data store.
    /// - Parameter character: Character to recruit to squad.
    func recruitToSquad(character: Character)
    
    /// Fire squad member from squad, saving to data store.
    /// - Parameter squadMember: Squad member to be fired.
    func fireFromToSquad(squadMember: SquadMemberProtocol)
}
