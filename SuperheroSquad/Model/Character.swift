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
    
    /// Initialise an empty placeholder character.
    init() {
        name = "placeholder"
        bio = ""       
    }
    
    /// Initialise from Marvel API results character..
    /// - Parameter marvelResultCharacter: Marvel API results character.
    init(_ marvelResultCharacter: MarvelResultCharacter) {
        name = marvelResultCharacter.name
        bio = marvelResultCharacter.description
        photoURL = URL(string: "\(marvelResultCharacter.thumbnail.path).\(marvelResultCharacter.thumbnail.ext)")
    }
    
    /// Name of character.
    var name: String
    
    /// Description of character.
    var bio: String
    
    /// URL of photo of character.
    var photoURL: URL?
    
    /// Image of character, if downloaded.
    var photo: UIImage?
}
