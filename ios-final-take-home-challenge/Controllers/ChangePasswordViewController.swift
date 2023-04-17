//
//  ChangePasswordViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import UIKit

class ChangePasswordViewController: MainViewController, MainStoryboarded, CustomViewButtonDelegate {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var enterPasswordView: CustomViewWithTextField!
    @IBOutlet weak var reEnterPasswordView: CustomViewWithTextField!
    @IBOutlet weak var saveChangeButtonView: CustomViewButton!
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(backButtonTitle: "")
        configureButton(button: saveChangeButtonView.customButton)
        
        enterPasswordView.inputTextField.isSecureTextEntry = true
        reEnterPasswordView.inputTextField.isSecureTextEntry = true
        
        enterPasswordView.inputTextField.delegate = self
        reEnterPasswordView.inputTextField.delegate = self
        
        saveChangeButtonView.delegate = self
    }
    
    // MARK: - Function
    func customViewButtonTapped(sender: CustomViewButton) {
        // Show Indicator when button is tapped - method is within `MainViewController`
        showLoadingIndicator(on: saveChangeButtonView.customButton)
        
        // Safely unwrap and check for empty fields - if any field is empty, call showAlert method
        guard let newPassword = enterPasswordView.inputTextField.text, !newPassword.isEmpty,
              let confirmNewPassword = reEnterPasswordView.inputTextField.text, !confirmNewPassword.isEmpty else {
            showAlert(title: "Error", message: NetworkError.emptyFields.localizedDescription, buttonTitle: "Try Again") { _ in
                // Hide Indicator when button is tapped - method is within `MainViewController`
                self.hideLoadingIndicator(on: self.saveChangeButtonView.customButton, buttonTitle: "Change Password")
            }
            return
        }
        
        // Check if both fields match each other, if not, call showAlert method
        if newPassword != confirmNewPassword {
            showAlert(title: "Error", message: NetworkError.passwordMismatch.localizedDescription, buttonTitle: "Try Again") { _ in
                // Hide Indicator when button is tapped - method is within `MainViewController`
                self.hideLoadingIndicator(on: self.saveChangeButtonView.customButton, buttonTitle: "Change Password")
            }
            return
        }
        
        let passwordData = PasswordData(newPassword: newPassword, confirmNewPassword: confirmNewPassword)
        let changePasswordEndpoint = ChangePasswordEndpoint(passwordData: passwordData)
        NetworkManager.shared.request(endpoint: changePasswordEndpoint) { (result: Result<ChangePasswordResponse, NetworkError>) in
            switch result {
            case .success(let changePasswordResponse):
                self.showAlert(title: "Success!", message: changePasswordResponse.msg, buttonTitle: "OK") { _ in
                    // Hide Indicator when button is tapped - method is within `MainViewController`
                    self.hideLoadingIndicator(on: self.saveChangeButtonView.customButton, buttonTitle: "Change Password")
                }
            case .failure(let networkError):
                self.showAlert(title: "Error", message: "Password Change Failed: \(networkError.localizedDescription)", buttonTitle: "Try Again") { _ in
                    // Hide Indicator when button is tapped - method is within `MainViewController`
                    self.hideLoadingIndicator(on: self.saveChangeButtonView.customButton, buttonTitle: "Change Password")
                }
            }
        }
    }
}

// MARK: - Extension
extension ChangePasswordViewController: UITextFieldDelegate {
    // Enable dismiss of keyboard when the user taps "return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
