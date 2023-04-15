//
//  Endpoint.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import Foundation

protocol Endpoint {
    var identifier: String { get }
    var httpMethod: HttpMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

extension Endpoint {
    var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        if let token = UserDefaults.standard.string(forKey: "authenticationAPI") {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
}

