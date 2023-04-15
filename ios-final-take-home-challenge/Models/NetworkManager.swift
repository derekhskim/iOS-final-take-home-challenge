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
            switch endpoint.identifier {
            case "getProfile":
                let response: [String: Any] = [
                    "msg": "Profile fetched successfully",
                    "msg_code": 200,
                    "data": [
                        "firstName": "John",
                        "userName": "john.doe",
                        "lastName": "Doe"
                    ]
                ]
                if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                }
            case "updateProfile":
                let response: [String: Any] = [
                    "msg": "Profile updated successfully",
                    "msg_code": 200,
                    "data": [
                        "firstName": "John",
                        "userName": "john.doe",
                        "lastName": "Doe"
                    ]
                ]
                if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                }
            case "changePassword":
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
                print("Unknown endpoint identifier")
            }
        }
    }
}
