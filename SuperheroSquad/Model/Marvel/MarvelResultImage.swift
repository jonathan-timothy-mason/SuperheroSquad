//
//  MarvelResultImage.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 04/12/2021.
//

import Foundation

/// Image, part of JSON response object for Marvel API results.
struct MarvelResultImage: Codable {
    let path: String
    let ext: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
