//
//  UpdateProfileEndpoint.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import Foundation

struct UpdateProfileEndpoint: Endpoint {
    var identifier: String { return "updateProfile" }
    var httpMethod: HttpMethod { return .post }
    var headers: [String : String] { return defaultHeaders }
    var body: Data? { return nil }
}
