//
//  NetworkError.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import Foundation

// Handle Error Cases
enum NetworkError: Error {
    case invalidResponse
    case emptyFields
    case passwordMismatch
    
    // Set localizedDescriptions for each error cases
    var localizedDescription: String {
            switch self {
            case .invalidResponse:
                return "The server returned an invalid response. Please try again later."
            case .emptyFields:
                return "One or more required fields are empty."
            case .passwordMismatch:
                return "The provided passwords do not match."
            }
        }
}
