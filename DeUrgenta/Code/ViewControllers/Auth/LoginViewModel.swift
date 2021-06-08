//
//  LoginViewModel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.04.2021.
//

import UIKit
import Promises

class LoginViewModel: NSObject {
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
    
    var email = ""
    var password = ""
    
    func submit() -> Promise<()> {
        storeCredentials()
        return authenticateWithStoredCredentials()
    }
    
    func validate() -> Promise<()> {
        let promise = Promise<()>.pending()
        guard !email.isEmpty else {
            promise.reject(ModelError.missing(what: .email))
            return promise
        }
        guard !password.isEmpty else {
            promise.reject(ModelError.missing(what: .password))
            return promise
        }
        guard email.isValidEmail else {
            promise.reject(ModelError.incorrect(what: .email))
            return promise
        }
        promise.fulfill(())
        return promise
    }
    
    private func storeCredentials() {
        AccountManager.shared.email = email
        AccountManager.shared.password = password
    }
    
    private func authenticateWithStoredCredentials() -> Promise<()> {
        storeCredentials()
        return AccountManager.shared.authenticate().then {
            AccountManager.shared.createStoredUserIfNecessary()
        }
    }

}
