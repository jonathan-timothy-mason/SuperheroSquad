//
//  TestSquadMember.swift
//  SuperheroSquadTests
//
//  Created by Jonathan Mason on 06/12/2021.
//

import Foundation
@testable import SuperheroSquad

/// Squad member for unit testing.
class TestSquadMember: SquadMemberProtocol {
    /// Initialise test squad member.
    init() {
        name = "dontCare"
        bio = "dontCare"
    }
    
    /// Initialise test squad member.
    /// - Parameters:
    ///   - name:  Name of squad member.
    ///   - bio:  Description of squad member.
    init(name: String, bio: String) {
        self.name = name
        self.bio = bio
    }
    
    var name: String?
    
    var bio: String?
    
    var photo: Data?
}
