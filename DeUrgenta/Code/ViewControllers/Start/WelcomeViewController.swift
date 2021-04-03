//
//  ViewController.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 01.04.2021.
//

import UIKit
import CoreLocation

class WelcomeViewController: DUViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func handleSignupAction(_ sender: Any) {
        let next = SearchAddressViewController()
        AppRouter.shared.push(next)
    }
    
    @IBAction func handleLoginAction(_ sender: Any) {
        let next = InfoConfigurationViewController()
        AppRouter.shared.push(next)
    }
}

