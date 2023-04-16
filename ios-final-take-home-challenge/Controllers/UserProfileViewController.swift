//
//  UserProfileViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import UIKit

class UserProfileViewController: MainViewController, MainStoryboarded {
    
    weak var coordinator: MainCoordinator?
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // MARK: - @IBAction
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserProfile()
        updateUserProfile()
        setupNavigationBar()
        
    }

    func getUserProfile() {
        let getProfileEndpoint = GetProfileEndpoint()
        NetworkManager.shared.request(endpoint: getProfileEndpoint) { (result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                
                self.userNameTextField.text = response.data.userName
                self.lastNameTextField.text = response.data.lastName
                self.firstNameTextField.text = response.data.firstName
                
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
