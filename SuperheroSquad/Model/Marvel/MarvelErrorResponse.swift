//
//  MarvelErrorResponse.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import Foundation

/// JSON response object for Marvel API error.
struct MarvelErrorResponse: Codable {
    let code: Int
    let status: String
}

extension MarvelErrorResponse: LocalizedError {
    var errorDescription: String? {
        return status
    }
}
