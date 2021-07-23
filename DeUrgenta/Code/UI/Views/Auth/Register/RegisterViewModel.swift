//
//  RegisterViewModel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 22.07.2021.
//

import Foundation
import SwiftUI
import Promises

extension RegisterView {
    
    class ViewModel: ObservableObject {
        @Published var firstName: String = ""
        @Published var lastName: String = ""
        @Published var email: String = ""
        @Published var password: String = ""
        
        @Published var isSuccess = false
        
        @Published var errorMessage: String?
        @Published var isError = false

        @Published var isTermsAgreed = false

        func submit() {
            
        }
    }

}
