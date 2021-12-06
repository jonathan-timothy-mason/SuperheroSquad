//
//  SquadMemberProtocol.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 06/12/2021.
//

import Foundation

/// SquadMember protocol to allow dependency injection.
protocol SquadMemberProtocol {
    /// Name of squad member.
    var name: String? { get set }
    
    // Description of squad member.
    var bio: String? { get set }
    
    // Photo of squad member.
    var photo: Data? { get set }
}
