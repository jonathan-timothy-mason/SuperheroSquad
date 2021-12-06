//
//  SquadMemberProtocolExtension.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 06/12/2021.
//

import Foundation

/// SquadMember array extension for helper.
/// - Note: From answer to "How can I extend typed Arrays in Swift?" by Andrew Schreiber:
/// https://stackoverflow.com/questions/24027116/how-can-i-extend-typed-arrays-in-swift
extension Array where Element == SquadMemberProtocol {
    func canRecruite(character: Character) -> Bool {
        return self.count < Constants.squadSize && !self.contains { $0.name == character.name }
    }
}
