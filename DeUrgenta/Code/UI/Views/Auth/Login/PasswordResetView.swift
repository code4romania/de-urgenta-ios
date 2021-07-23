//
//  PasswordResetView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import SwiftUI

struct PasswordResetView: View {
    @State var email: String = ""
    
    var body: some View {
        VStack(spacing: 4) {
            FormTextField(label: "E-mail", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            Spacer()
            
            Button(action: {
                print("tapped")
            }, label: {
                Text("Reseteaza-ti parola")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(
                LargeButton(
                    bgColor: .accent,
                    fgColor: .mainBackground))
            
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PasswordResetView()
                .navigationTitle("Ti-ai uitat parola?")
                .padding()
        }
        
    }
}
