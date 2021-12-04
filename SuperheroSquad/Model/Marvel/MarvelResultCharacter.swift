//
//  MarvelResultResponseCharacter.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import Foundation

/// Character, part of JSON response object for Marvel API results.
struct MarvelResultCharacter: Codable {
    let name: String
    let description: String
    let thumbnail: MarvelResultImage
}
