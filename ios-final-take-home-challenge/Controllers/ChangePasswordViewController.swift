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
        
        changePasswordButton.isUserInteractionEnabled = false
        changePasswordButton.setAttributedTitle(NSAttributedString(string: "", attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.color = UIColor.white
        indicator.startAnimating()
        changePasswordButton.addSubview(indicator)
        indicator.center = CGPoint(x: changePasswordButton.bounds.midX, y: changePasswordButton.bounds.midY)
        
        let changePasswordEndpoint = ChangePasswordEndpoint()
        NetworkManager.shared.request(endpoint: changePasswordEndpoint) { (result: Result<ChangePasswordResponse, NetworkError>) in
            switch result {
            case .success(let changePasswordResponse):
                print("Password Changed Successfully: \(changePasswordResponse)")
                
                indicator.removeFromSuperview()
                self.changePasswordButton.setAttributedTitle(NSAttributedString(string: "Save Changes", attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
                self.changePasswordButton.isUserInteractionEnabled = true
            case .failure(let networkError):
                print("Password Change Failed: \(networkError.localizedDescription)")
                
                indicator.removeFromSuperview()
                self.changePasswordButton.setAttributedTitle(NSAttributedString(string: "Save Changes", attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
                self.changePasswordButton.isUserInteractionEnabled = true
            }
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(backButtonTitle: "")
        configureButton()
        
    }
    
    func configureButton() {
        changePasswordButton.layer.borderWidth = 4
        changePasswordButton.layer.borderColor = UIColor.appColor(DKColor.LightGray).cgColor
        changePasswordButton.layer.cornerRadius = 5
    }
}
