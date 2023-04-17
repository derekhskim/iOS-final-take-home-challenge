//
//  UserProfileViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import UIKit

class UserProfileViewController: MainViewController, MainStoryboarded {
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    // MARK: - @IBOutlet
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var saveChangeButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    // MARK: - @IBAction
    @IBAction func saveChangeButtonTapped(_ sender: Any) {
        
        // Show Indicator when button is tapped - method is within `MainViewController`
        showLoadingIndicator(on: saveChangeButton)
        
        // Safely unwrap and check for empty fields - if any field is empty, call showAlert method
        guard let userName = userNameTextField.text, !userName.isEmpty,
              let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty else {
            showAlert(title: "Error", message: NetworkError.emptyFields.localizedDescription, buttonTitle: "Try Again") { _ in
                // Hide Indicator when button is tapped - method is within `MainViewController`
                self.hideLoadingIndicator(on: self.saveChangeButton, buttonTitle: "Save Change")
            }
            return
        }
        
        let userData = DataClass(firstName: firstName, userName: userName, lastName: lastName)
        let updateProfileEndpoint = UpdateProfileEndpoint(userData: userData)
        NetworkManager.shared.request(endpoint: updateProfileEndpoint) {(result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                self.showAlert(title: "Success!", message: "User information has been updated successfully!", buttonTitle: "OK") { _ in
                    // Pass userData of firstName, userName, and lastName as body and when success, save it in UserDefault.standard
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(response.data), forKey: "userProfile")
                    // Hide Indicator when button is tapped - method is within `MainViewController`
                    self.hideLoadingIndicator(on: self.saveChangeButton, buttonTitle: "Save Change")
                }
            case .failure(let networkError):
                self.showAlert(title: "Error", message: networkError.localizedDescription, buttonTitle: "Try again") { _ in
                    // Hide Indicator when button is tapped - method is within `MainViewController`
                    self.hideLoadingIndicator(on: self.saveChangeButton, buttonTitle: "Save Change")
                }
            }
        }
    }
    
    @IBAction func changePasswordButtonTapped(_ sender: Any) {
        coordinator?.goToChangePasswordVC()
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserProfile()
        setupNavigationBar(backButtonTitle: "Dashboard")
        
        configureButton(button: saveChangeButton)
        configureButton(button: changePasswordButton)
    }
    
    // MARK: - Function
    func getUserProfile() {
        let getProfileEndpoint = GetProfileEndpoint()
        NetworkManager.shared.request(endpoint: getProfileEndpoint) { (result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                self.userNameTextField.text = response.data.userName
                self.lastNameTextField.text = response.data.lastName
                self.firstNameTextField.text = response.data.firstName
            case .failure(let networkError):
                self.showAlert(title: "Error", message: networkError.localizedDescription, buttonTitle: "Go Back") { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
