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
        
        let changePasswordEndpoint = ChangePasswordEndpoint()
        NetworkManager.shared.request(endpoint: changePasswordEndpoint) { (result: Result<ChangePasswordResponse, NetworkError>) in
            switch result {
            case .success(let changePasswordResponse):
                print("Password Changed Successfully: \(changePasswordResponse)")
                // Hide Indicator when button is tapped - method is within `MainViewController`
                self.hideLoadingIndicator(on: self.changePasswordButton, buttonTitle: "Change Password")
            case .failure(let networkError):
                // Hide Indicator when button is tapped - method is within `MainViewController`
                print("Password Change Failed: \(networkError.localizedDescription)")
                self.hideLoadingIndicator(on: self.changePasswordButton, buttonTitle: "Change Password")
            }
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(backButtonTitle: "")
        configureButton(button: changePasswordButton)
        
    }
    
}
