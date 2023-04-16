//
//  MainViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-15.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupNavigationBar(backButtonTitle titleText: String) {
        let backButton = UIBarButtonItem()
        backButton.title = titleText
        backButton.tintColor = UIColor.appColor(DKColor.DarkGray)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
