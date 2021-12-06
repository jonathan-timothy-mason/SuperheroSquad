//
//  StringExtension.swift
//  SuperHeroSquad
//
//  Created by Jonathan Mason on 03/12/2021.
//

import Foundation
import CryptoKit

/// String extension for using Marvel API.
extension String {
    
    /// Get MD5 encrypted version of string.
    /// - Returns: Encrypted string.
    /// - Note: From answer to 'How can I convert a String to an MD5 hash in iOS using Swift?' by mluisbrown:
    /// https://stackoverflow.com/questions/32163848/how-can-i-convert-a-string-to-an-md5-hash-in-ios-using-swift
    func toMD5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
