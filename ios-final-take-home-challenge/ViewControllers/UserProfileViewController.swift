//
//  UserProfileViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import UIKit

class UserProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserProfile()
        updateUserProfile()
    }

    func getUserProfile() {
        let getProfileEndpoint = GetProfileEndpoint()
        NetworkManager.shared.request(endpoint: getProfileEndpoint) { (result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                print("Successfully retrieved User: \(response)")
            case .failure(let networkError):
                print("Error fetching user's information: \(networkError.localizedDescription)")
            }
            
        }
    }
    
    func updateUserProfile() {
        let updateProfileEndpoint = UpdateProfileEndpoint()
        NetworkManager.shared.request(endpoint: updateProfileEndpoint) {(result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                print("Successfully updated user: \(response)")
            case .failure(let networkError):
                print("Update user failed: \(networkError.localizedDescription)")
            }
        }
    }
}
