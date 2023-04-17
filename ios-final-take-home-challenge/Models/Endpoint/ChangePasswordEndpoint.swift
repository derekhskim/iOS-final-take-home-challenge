//
//  ChangePasswordEndpoint.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import Foundation

struct ChangePasswordEndpoint: Endpoint {
    let passwordData: PasswordData
    
    var path: String { return "/profiles/password/change" }
    var httpMethod: HttpMethod { return .post }
    var headers: [String : String] { return defaultHeaders }
    
    var body: Data? {
        return try? JSONEncoder().encode(passwordData)
    }
}
