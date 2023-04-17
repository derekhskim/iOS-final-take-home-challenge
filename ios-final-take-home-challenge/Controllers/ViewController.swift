//
//  ViewController.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-14.
//

import UIKit

class ViewController: MainViewController, MainStoryboarded {

    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    // MARK: - @IBAction
    @IBAction func goToUserProfileButtonTapped(_ sender: Any) {
        coordinator?.goToUserProfileVC()
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

