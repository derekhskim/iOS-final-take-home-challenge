//
//  NetworkManager.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    struct EmptyResponse: Codable {}
    
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void, userDefaultsSaving: ((T) -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            switch endpoint.path {
            case "/profiles/me":
                var response: [String: Any] = [
                    "msg": "Profile fetched successfully",
                    "msg_code": 200,
                    "data": [
                        "firstName": "Johnny B.",
                        "userName": "iOS User",
                        "lastName": "Goode"
                    ]
                ]
                if let userData = UserDefaults.standard.value(forKey: "userProfile") as? Data,
                   let userProfile = try? PropertyListDecoder().decode(DataClass.self, from: userData) {
                    response["data"] = [
                        "firstName": userProfile.firstName,
                        "userName": userProfile.userName,
                        "lastName": userProfile.lastName
                    ]
                }
                
                if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                }
            case "/profiles/update":
                if let body = endpoint.body, let userData = try? JSONDecoder().decode(DataClass.self, from: body) {
                    let response: [String: Any] = [
                        "msg": "Profile updated successfully",
                        "msg_code": 200,
                        "data": [
                            "firstName": userData.firstName,
                            "userName": userData.userName,
                            "lastName": userData.lastName
                        ]
                    ]
                    if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
                        do {
                            let responseObject = try JSONDecoder().decode(T.self, from: data)
                            userDefaultsSaving?(responseObject)
                            completion(.success(responseObject))
                        } catch {
                            completion(.failure(.invalidResponse))
                        }
                    }
                }
                
            case "/profiles/password/change":
                let response: [String: Any] = [
                    "msg": "Password changed successfully",
                    "msg_code": 200
                ]
                if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                }
            default:
                print("Unknown endpoint path")
            }
        }
    }
}
