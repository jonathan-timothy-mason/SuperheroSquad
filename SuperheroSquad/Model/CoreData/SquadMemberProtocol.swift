//
//  SquadMemberProtocol.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 06/12/2021.
//

import Foundation

/// Protocol to be implemented by SquadMember.
/// - Note: Core Data attibutes named more obscurely, whilst protocol provides main access to SquadMember for app. This allows TestSquadMember to be injected during testing.
protocol SquadMemberProtocol {
    /// Name of squad member.
    var name: String? { get set }
    
    // Description of squad member.
    var bio: String? { get set }
    
    // Photo of squad member.
    var photo: Data? { get set }
}
