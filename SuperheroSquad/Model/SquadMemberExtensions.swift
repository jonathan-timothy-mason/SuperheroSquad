//
//  SquadMemberExtensions.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 05/12/2021.
//

import Foundation

/// SquadMember extension for squad actions.
extension SquadMember {
    /// Create new squad member from supplied character and recruit to squad, saving to data store.
    /// - Parameter character: Character to recruit to squad.
    static func recruitToSquad(character: Character) {
        let squadMember = SquadMember(context: DataController.shared.viewContext)
        squadMember.name = character.name
        squadMember.bio = character.bio
        squadMember.photo = character.bigPhoto?.pngData()
        DataController.shared.saveDataStore()
    }
    
    /// Fire squad member from squad, saving to data store.
    /// - Parameter squadMember: Squad member to be fired.
    static func fireFromToSquad(squadMember: SquadMember) {
        DataController.shared.viewContext.delete(squadMember)
        DataController.shared.saveDataStore()
    }
}

/// SquadMember array extension for helper.
/// - Note: From answer to "How can I extend typed Arrays in Swift?" by Andrew Schreiber:
/// https://stackoverflow.com/questions/24027116/how-can-i-extend-typed-arrays-in-swift
extension Array where Element == SquadMember {
    func canRecruite(character: Character) -> Bool {
        return self.count < 5 && !self.contains { $0.name == character.name }
    }
}
