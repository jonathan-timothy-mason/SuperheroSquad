//
//  Character.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 04/12/2021.
//

import Foundation
import UIKit

/// Character for selection into squad.
class Character {
    static let defaultSystemImageName = "questionmark.circle.fill"
    
    /// Initialise empty placeholder character.
    init() {
        name = "placeholder"
        bio = ""       
    }
    
    /// Initialise test character.
    init(name: String, bio: String) {
        self.name = name
        self.bio = bio
    }
    
    /// Initialise from Marvel API results character.
    /// - Parameter marvelResultCharacter: Marvel API results character.
    init(_ marvelResultCharacter: MarvelResultCharacter) {
        name = marvelResultCharacter.name
        bio = marvelResultCharacter.description
        smallPhotoURL = URL(string: "\(marvelResultCharacter.thumbnail.path)/\(MarvelClient.Endpoints.thumbnailVariant).\(marvelResultCharacter.thumbnail.ext)")
        bigPhotoURL = URL(string: "\(marvelResultCharacter.thumbnail.path)/\(MarvelClient.Endpoints.mainImageVariant).\(marvelResultCharacter.thumbnail.ext)")
    }
    
    /// Initialise from date store squad member.
    /// - Parameter squadMember: Data store squad member.
    init(_ squadMember: SquadMemberProtocol) {
        name = squadMember.name!
        bio = squadMember.bio!
        if let photo = squadMember.photo {
            bigPhoto = UIImage(data: photo)
        }
    }
    
    /// Name of character.
    var name: String
    
    /// Description of character.
    var bio: String
    
    /// URL of small image of character.
    var smallPhotoURL: URL?
    
    /// URL of big image of character.
    var bigPhotoURL: URL?
    
    /// Small image of character, if downloaded.
    var smallPhoto: UIImage?
    
    /// Big image if character,, if downloaded.
    var bigPhoto: UIImage?
}
