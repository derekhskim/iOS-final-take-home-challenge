//
//  MainViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-15.
//

import UIKit

class MainViewController: UIViewController {
    
    private let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupNavigationBar(backButtonTitle titleText: String) {
        let backButton = UIBarButtonItem()
        backButton.title = titleText
        backButton.tintColor = UIColor.appColor(DKColor.DarkGray)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func configureButton(button UIButton: UIButton) {
        UIButton.layer.borderWidth = 4
        UIButton.layer.borderColor = UIColor.appColor(DKColor.LightGray).cgColor
        UIButton.layer.cornerRadius = 5
    }
    
    func showLoadingIndicator(on button: UIButton) {
        button.isUserInteractionEnabled = false
        button.setAttributedTitle(NSAttributedString(string: "", attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
        indicator.color = UIColor.white
        indicator.startAnimating()
        button.addSubview(indicator)
        indicator.center = CGPoint(x: button.bounds.midX, y: button.bounds.midY)
    }
    
    func hideLoadingIndicator(on button: UIButton, buttonTitle title: String) {
        indicator.removeFromSuperview()
        button.setAttributedTitle(NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 24)]), for: .normal)
        button.isUserInteractionEnabled = true
    }
}
