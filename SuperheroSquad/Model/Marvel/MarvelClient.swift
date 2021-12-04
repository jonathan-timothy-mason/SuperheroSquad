//
//  MarvelClient.swift
//  SuperHeroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import Foundation
import UIKit

/// Provides access to Marvel API.
class MarvelClient {

    /// Endpoints of Marvel API.
    enum Endpoints {
        static let baseURL = "https://gateway.marvel.com/v1/public"
        static let apiPublicKey = "31191f798942cbab6151dd3983736b13"
        static let apiPrivateKey = "78ecea7b5cb58088d72e4c34b3e3406b6054c5e9"
        static let appStartDate = Date()

        case getCharacters
        
        /// Construct endpoint according to current case.
        /// - Returns: Endpoint URL as string.
        func constructURL() -> String {
            switch(self) {
            case .getCharacters:
                let ts = String(Int(Endpoints.appStartDate.timeIntervalSinceNow))
                let hash = (ts + Endpoints.apiPrivateKey + Endpoints.apiPublicKey).toMD5()
                return "\(Endpoints.baseURL)/characters?ts=\(ts)&apikey=\(Endpoints.apiPublicKey)&hash=\(hash)&limit=100"
            }
        }
        
        /// Endpoint of current case.
        /// - Returns: Endpoint URL.
        var url: URL {
            return URL(string: constructURL())!
        }
    }
    
    /// Send GET request to retrieve characters from Marvel API.
    /// - Parameters:
    ///   - completion: Function to call upon completion.
    static func getCharacters(completion: @escaping ([MarvelResultCharacter], Error?) -> Void) {
        taskForMarvelGetRequest(url: Endpoints.getCharacters.url, marvelResultType: MarvelResultCharacter.self) { response, error in
            if let response = response {
                completion(response.data.results, nil)
            }
            else {
                completion([], error)
            }
        }
    }
    
    /// Send GET request to retrieve results of specified type from Marvel API.
    /// - Parameters:
    ///   - url: URL endpoint of API.
    ///   - marvelResultType: Type of Marvel result data.
    ///   - completion: Function to call upon completion.
    static func taskForMarvelGetRequest<T: Decodable>(url: URL, marvelResultType: T.Type, completion: @escaping (MarvelResultResponse<T>?, Error?) -> Void) {
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                // There was an error making request.
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                // Attempt to decode response as results response.
                let responseObject = try decoder.decode(MarvelResultResponse<T>.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    // Attempt to decode response as Marvel error response.
                    let errorResponseObject = try decoder.decode(MarvelErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponseObject)
                    }
                }
                catch {
                    do {
                        // Attempt to decode response as general error response.
                        let errorResponseObject = try decoder.decode(GeneralErrorResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(nil, errorResponseObject)
                        }
                    }
                    catch {
                        // Just report error generated during decoding.
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

