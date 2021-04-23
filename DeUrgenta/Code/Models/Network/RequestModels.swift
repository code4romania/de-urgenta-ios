//
//  RegisterRequest.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 22.04.2021.
//

import Foundation

struct AuthResponse: Decodable {
    var token: String
    var success: Bool?
    var errors: [String]?
}

struct RegisterRequest: Encodable {
    var email: String
    var password: String
}

typealias RegisterResponse = String

struct LoginRequest: Encodable {
    var email: String
    var password: String
}
