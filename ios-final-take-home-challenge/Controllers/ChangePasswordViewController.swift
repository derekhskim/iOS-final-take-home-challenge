//
//  ChangePasswordViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import UIKit

class ChangePasswordViewController: MainViewController, MainStoryboarded {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    // MARK: - @IBAction
    @IBAction func changePasswordButtonTapped(_ sender: Any) {
        
        // Show Indicator when button is tapped - method is within `MainViewController`
        showLoadingIndicator(on: changePasswordButton)
        
        // Safely unwrap and check for empty fields - if any field is empty, call showAlert method
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty,
              let confirmNewPassword = reEnterPasswordTextField.text, !confirmNewPassword.isEmpty else {
            showAlert(title: "Error", message: NetworkError.emptyFields.localizedDescription, buttonTitle: "Try Again") { _ in
                // Hide Indicator when button is tapped - method is within `MainViewController`
                self.hideLoadingIndicator(on: self.changePasswordButton, buttonTitle: "Change Password")
            }
            return
        }
        
        // Check if both fields match each other, if not, call showAlert method
        if newPassword != confirmNewPassword {
            showAlert(title: "Error", message: NetworkError.passwordMismatch.localizedDescription, buttonTitle: "Try Again") { _ in
                // Hide Indicator when button is tapped - method is within `MainViewController`
                self.hideLoadingIndicator(on: self.changePasswordButton, buttonTitle: "Change Password")
            }
            return
        }
        
        let passwordData = PasswordData(newPassword: newPassword, confirmNewPassword: confirmNewPassword)
        let changePasswordEndpoint = ChangePasswordEndpoint(passwordData: passwordData)
        NetworkManager.shared.request(endpoint: changePasswordEndpoint) { (result: Result<ChangePasswordResponse, NetworkError>) in
            switch result {
            case .success(let changePasswordResponse):
                self.showAlert(title: "Success!", message: "Password Changed Successfully!", buttonTitle: "OK") { _ in
                    // Hide Indicator when button is tapped - method is within `MainViewController`
                    print("Response: \(changePasswordResponse)")
                    self.hideLoadingIndicator(on: self.changePasswordButton, buttonTitle: "Change Password")
                }
            case .failure(let networkError):
                self.showAlert(title: "Error", message: "Password Change Failed: \(networkError.localizedDescription)", buttonTitle: "Try Again") { _ in
                    // Hide Indicator when button is tapped - method is within `MainViewController`
                    self.hideLoadingIndicator(on: self.changePasswordButton, buttonTitle: "Change Password")
                }
            }
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(backButtonTitle: "")
        configureButton(button: changePasswordButton)
        
        newPasswordTextField.isSecureTextEntry = true
        reEnterPasswordTextField.isSecureTextEntry = true
        
    }
    
}
