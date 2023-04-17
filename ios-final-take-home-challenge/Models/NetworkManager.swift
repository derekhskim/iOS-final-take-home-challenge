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
        
        // If real endpoint call, below is the code that will be used, but since this is a mockup, it is being handled differently.
        /*
        guard let url = endpoint.url else {
            print("Error with URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
                
                switch response.statusCode {
                case 200..<300:
                    if data == nil || data?.isEmpty == true {
                        if T.self == EmptyResponse.self {
                            completion(.success(EmptyResponse() as! T))
                            return
                        } else {
                            print("Error: Did not receive data")
                            return
                        }
                    }
                    
                    guard let data = data else { return }
                    
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        userDefaultsSaving?(responseObject)
                        completion(.success(responseObject))
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                default:
                    print("Error: Received HTTP response with status code \(response.statusCode)")
                    let error = NSError(domain: NSURLErrorDomain, code: response.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
                
            }
        }
        task.resume()
        */
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            switch endpoint.path {
            case "/profiles/me":
                // Default Mockup Response if there aren't any saved data
                var response: [String: Any] = [
                    "msg": "Profile fetched successfully",
                    "msg_code": 200,
                    "data": [
                        "firstName": "Johnny B.",
                        "userName": "iOS User",
                        "lastName": "Goode"
                    ]
                ]
                // Check if there is saved data via UpdateUserEndpoint call - if yes, show saved data as response, if not, default response value above will show
                if let userData = UserDefaults.standard.value(forKey: "userProfile") as? Data,
                   let userProfile = try? PropertyListDecoder().decode(DataClass.self, from: userData) {
                    response["data"] = [
                        "firstName": userProfile.firstName,
                        "userName": userProfile.userName,
                        "lastName": userProfile.lastName
                    ]
                }
                
                // Convert the mockup response dictionary to data format and decode it to simulate a network call
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
                    
                    // Convert the mockup response dictionary to data format and decode it to simulate a network call for updating user profile
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
                
                // Convert the mockup response dictionary to data format and decode it to simulate a network call
                if let data = try? JSONSerialization.data(withJSONObject: response, options: []) {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                }
            default:
                print("Unknown endpoint path: \(endpoint.baseURL)\(endpoint.path)")
            }
        }
    }
}
