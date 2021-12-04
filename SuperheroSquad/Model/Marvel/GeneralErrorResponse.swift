//
//  GeneralErrorResponse.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 04/12/2021.
//

import Foundation

// JSON response object for general error.
struct GeneralErrorResponse: Codable {
    let code: String
    let message: String
}

extension GeneralErrorResponse: LocalizedError {
    var errorDescription: String? {
        return message
    }
}
