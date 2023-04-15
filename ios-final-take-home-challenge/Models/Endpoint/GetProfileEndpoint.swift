//
//  GetProfileEndpoint.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import Foundation

struct GetProfileEndpoint: Endpoint {
    var identifier: String { return "getProfile" }
    var httpMethod: HttpMethod { return .get }
    var headers: [String : String] { return defaultHeaders }
    var body: Data? { return nil }
}
