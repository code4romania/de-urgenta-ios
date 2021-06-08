//
//  AccountManager.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 22.04.2021.
//

import Foundation
import SwiftKeychainWrapper
import Promises

class AccountManager {
    static let shared = AccountManager()
    
    enum AccountError: Error, LocalizedError {
        case noCredentials
    }
    
    /// Token is only stored in memory and it will refresh on app open
    var token: String?
    
    var email: String? {
        set {
            if newValue == nil {
                KeychainWrapper.standard.remove(forKey: .email)
            } else {
                KeychainWrapper.standard[.email] = newValue
            }
        }
        get {
            return KeychainWrapper.standard[.email]
        }
    }

    var password: String? {
        set {
            if newValue == nil {
                KeychainWrapper.standard.remove(forKey: .password)
            } else {
                KeychainWrapper.standard[.password] = newValue
            }
        }
        get {
            return KeychainWrapper.standard[.password]
        }
    }
    
    var hasCredentials: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var isAuthenticated: Bool {
        return token != nil
    }
    
    func authenticate() -> Promise<()> {
        let promise = Promise<()>.pending()
        guard let email = email,
              let password = password else {
            promise.reject(AccountError.noCredentials)
            return promise
        }
        
        let request = LoginRequest(email: email, password: password)
        DUAPI.shared.login(request)
            .then { response in
                self.token = response.token
                promise.fulfill(())
            }
            .catch { promise.reject($0) }
        return promise
    }
    
    func createStoredUserIfNecessary() {
        guard let email = email else {
            LogDebug("No email, skipping...")
            return
        }
        
        do {
            guard try LocalStorage.shared.getUser(byEmail: email) == nil else {
                LogDebug("Stored user with this email already exists. Skipping...")
                return
            }

            try LocalStorage.shared.createUser(withEmail: email)
            try LocalStorage.shared.save()
            LogInfo("Created Stored User.")
        } catch {
            LogError("Could not create stored user: \(error)")
        }
    }
    
    func logout() {
        token = nil
        email = nil
        password = nil
        LogInfo("User logged out.")
    }
}

extension KeychainWrapper.Key {
    static let token: KeychainWrapper.Key = "auth_token"
    static let email: KeychainWrapper.Key = "auth_email"
    static let password: KeychainWrapper.Key = "auth_password"
}
