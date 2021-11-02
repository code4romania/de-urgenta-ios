//
//  LoginViewModel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import Foundation
import Promises

extension LoginView {
    
    class ViewModel: ObservableObject {
        @Published var email: String = ""
        @Published var password: String = ""
        
        @Published var isLoading = false
        @Published var isLoggedIn = false
        @Published var errorMessage: String?
        @Published var isError = false

        private var currentError: ModelError? {
            didSet {
                self.errorMessage = currentError?.localizedDescription
                isError = currentError != nil
            }
        }
        
        enum FieldType {
            case email
            case password
            
            var localizedName: String {
                switch self {
                case .email:
                    return "adresa de email"
                case .password:
                    return "parola"
                }
            }
        }
        
        enum ModelError: Error, LocalizedError {
            case incorrect(what: FieldType)
            case missing(what: FieldType)
            case serverError(reason: Error)
            
            var errorDescription: String? {
                switch self {
                case .incorrect(let what):
                    return what.localizedName.capitalized + " invalidă"
                case .missing(let what):
                    return "Te rog să introduci " + what.localizedName
                case .serverError(let reason):
                    return "Eroare de la server: " + reason.localizedDescription
                }
            }
        }
        
        init() {
            #if DEBUG
            email = Config.shared.configValue(of: .debugLoginEmail)
            password = Config.shared.configValue(of: .debugLoginPass)
            #endif
        }
        
        func submit() {
            guard !isLoading else { return }
            isError = false
            validate()
            guard !isError else { return }
            isLoading = true
            storeCredentials()
            authenticateWithStoredCredentials()
        }
        
        func validate() {
            guard !email.isEmpty else {
                currentError = ModelError.missing(what: .email)
                return
            }
            guard !password.isEmpty else {
                currentError = ModelError.missing(what: .password)
                return
            }
            guard email.isValidEmail else {
                currentError = ModelError.incorrect(what: .email)
                return
            }
            currentError = nil
            return
        }
        
        private func storeCredentials() {
            AccountManager.shared.email = email
            AccountManager.shared.password = password
        }
        
        private func authenticateWithStoredCredentials() {
            AccountManager.shared.authenticate()
                .then { [weak self] in
                    AccountManager.shared.createStoredUserIfNecessary()
                    self?.isLoggedIn = true
                    self?.isLoading = false
                    MainAppEnvironment.shared.navigationRoute = .authenticated
                }
                .catch { [weak self] error in
                    self?.currentError = ModelError.serverError(reason: error)
                    self?.isLoading = false
                }
        }

    }
    
}
