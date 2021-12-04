//
//  Character.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 04/12/2021.
//

import Foundation
import UIKit

/// Character for selection into squad.
struct Character {
    static let defaultSystemImageName = "questionmark.circle.fill.ar"
       
    /// Default initialiser.
    /// - Parameters:
    ///   - name: Name of character.
    ///   - bio: Description of character.
    ///   - photoURL: URL of photo of character.
    ///   - photo: Image of character.
    init(name: String, bio: String, photoURL: URL?, photo: UIImage?) {
        self.name = name
        self.bio = bio
        self.photoURL = photoURL
        self.photo = photo
    }
    
    /// Initialise from Marvel API results character..
    /// - Parameter marvelResultCharacter: Marvel API results character.
    init(_ marvelResultCharacter: MarvelResultCharacter) {
        name = marvelResultCharacter.name
        bio = marvelResultCharacter.description
        photoURL = URL(string: "\(marvelResultCharacter.thumbnail.path).\(marvelResultCharacter.thumbnail.ext)")
        photo = nil
    }
    
    /// Name of character.
    let name: String
    
    /// Description of character.
    let bio: String
    
    /// URL of photo of character.
    let photoURL: URL?
    
    /// Image of character, if downloaded.
    let photo: UIImage?

}
