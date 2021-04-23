//
//  DUAPI.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 22.04.2021.
//

import Foundation
import Promises

class DUAPI: NSObject {
    static let shared = DUAPI()
    
    func register(_ request: RegisterRequest) -> Promise<RegisterResponse> {
        return DUAPICore.shared.post(to: .register, body: request, authenticated: false)
    }
    
    func login(_ request: LoginRequest) -> Promise<AuthResponse> {
        return DUAPICore.shared.post(to: .login, body: request, authenticated: false)
    }
}
