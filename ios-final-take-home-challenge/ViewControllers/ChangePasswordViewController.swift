//
//  ChangePasswordViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePassword()
    }
    
    func changePassword() {
        let changePasswordEndpoint = ChangePasswordEndpoint()
        NetworkManager.shared.request(endpoint: changePasswordEndpoint) { (result: Result<ChangePasswordResponse, NetworkError>) in
            switch result {
            case .success(let changePasswordResponse):
                print("Password Changed Successfully: \(changePasswordResponse)")
            case .failure(let networkError):
                print("Password Change Failed: \(networkError.localizedDescription)")
            }
        }
    }
}
