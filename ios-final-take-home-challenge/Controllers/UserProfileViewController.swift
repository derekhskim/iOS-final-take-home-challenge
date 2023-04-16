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
        
        saveChangeButton.isUserInteractionEnabled = false
        saveChangeButton.setAttributedTitle(NSAttributedString(string: "", attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.color = UIColor.white
        indicator.startAnimating()
        saveChangeButton.addSubview(indicator)
        indicator.center = CGPoint(x: saveChangeButton.bounds.midX, y: saveChangeButton.bounds.midY)

        let updateProfileEndpoint = UpdateProfileEndpoint()
        NetworkManager.shared.request(endpoint: updateProfileEndpoint) {(result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                print("Successfully updated user: \(response)")
                
                indicator.removeFromSuperview()
                self.saveChangeButton.setAttributedTitle(NSAttributedString(string: "Save Changes", attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
                self.saveChangeButton.isUserInteractionEnabled = true
            case .failure(let networkError):
                print("Update user failed: \(networkError.localizedDescription)")
                
                indicator.removeFromSuperview()
                self.saveChangeButton.setAttributedTitle(NSAttributedString(string: "Save Changes", attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
                self.saveChangeButton.isUserInteractionEnabled = true
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
        configureButton()
        
    }
    
    // MARK: - Function
    func configureButton() {
        saveChangeButton.layer.borderWidth = 4
        saveChangeButton.layer.borderColor = UIColor.appColor(DKColor.LightGray).cgColor
        saveChangeButton.layer.cornerRadius = 5
        
        changePasswordButton.layer.borderWidth = 4
        changePasswordButton.layer.borderColor = UIColor.appColor(DKColor.LightGray).cgColor
        changePasswordButton.layer.cornerRadius = 5
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
}
