//
//  TestDataController.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 06/12/2021.
//

import Foundation

class TestDataController: DataControllerProtocol {
    var squad: [SquadMemberProtocol] = []
    
    func loadDataStore() {
        // Not implmented.
    }
       
    func loadSquad() -> [SquadMemberProtocol] {
        return squad
    }
    
    func saveDataStore() {
        // Not implmented.
    }
    
    func recruitToSquad(character: Character) {
        let squadMember = TestSquadMember(name: character.name, bio: character.bio)
        squad.append(squadMember)
    }
    
    func fireFromToSquad(squadMember: SquadMemberProtocol) {
        if let squadMember = squadMember as? TestSquadMember {
            squad = squad.filter { $0.name != squadMember.name }
        }
    }
}
