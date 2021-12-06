//
//  SquadMemberExtension.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 05/12/2021.
//

import Foundation

/// SquadMember extension for squad actions.
extension SquadMember: SquadMemberProtocol {
    var name: String? {
        set { colName = newValue }
        get { return colName }
    }
    
    var bio: String?  {
        set { colBio = newValue }
        get { return colBio }
    }
    
    var photo: Data?  {
        set { colPhoto = newValue }
        get { return colPhoto }
    }
}
