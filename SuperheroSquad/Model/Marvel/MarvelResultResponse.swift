//
//  MarvelResultResponse.swift
//  SuperheroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import Foundation

/// JSON response object for Marvel API results.
struct MarvelResultResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let data: MarvelResultContainer<T>
}

/// Results container, part of JSON response object for Marvel API results.
struct MarvelResultContainer<T: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
