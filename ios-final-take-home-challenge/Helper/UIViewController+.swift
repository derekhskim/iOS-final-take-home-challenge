//
//  UIViewController+.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-16.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String, buttonAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction))
        self.present(alertController, animated: true, completion: nil)
    }
}
