//
//  NetworkError.swift
//  Alomafire-Project
//
//  Created by M A Hossan on 31/01/2023.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case other(Error)
    
    // Define the custom error

    var errorDescription: String? {
        switch self {
        case .badURL:
            return "This is a bad URL"
        case .other(let error):
            return error.localizedDescription
        }
    }

}
