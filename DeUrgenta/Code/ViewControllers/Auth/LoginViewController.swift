//
//  LoginViewController.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.04.2021.
//

import UIKit
import Promises

class LoginViewController: DUViewController {
    let model = OLoginViewModel()
    
    @IBOutlet weak var loginButton: DUActionButton!
    @IBOutlet weak var emailField: DUFormTextFieldContainer!
    @IBOutlet weak var passwordField: DUFormTextFieldContainer!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setStyle(.translucentDarkContent)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func handleLoginButtonTap(_ sender: Any) {
        updateModel()
        model.validate()
            .then { self.submit() }
            .then { self.handleSuccess() }
            .catch { error in
                self.isFullscreenSpinnerVisible = false
                self.showAlert(
                    withTitle: "Eroare",
                    message: "Autentificarea a eșuat: \(error.localizedDescription)")
            }
    }
    
    private func updateModel() {
        model.email = emailField.textField.text ?? ""
        model.password = passwordField.textField.text ?? ""
    }
    
    private func handleSuccess() {
        isFullscreenSpinnerVisible = false
        LogInfo("Logged in.")
        AppRouter.shared.navigateToDashboard()
    }
    
    private func submit() -> Promise<()> {
        isFullscreenSpinnerVisible = true
        return model.submit()
    }
    
}
