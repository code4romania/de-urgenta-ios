//
//  FormTextField.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import SwiftUI

struct FormTextField: View {
    let label: String
    @Binding var text: String
    var isSecure = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.smallFormLabel)
                .foregroundColor(.mainForeground)
            
            VStack {
                if isSecure {
                    SecureField("", text: $text)
                        .font(.formTextField)
                        .frame(height: 26)
                        .foregroundColor(.mainForeground)
                        .padding(EdgeInsets(top: 9, leading: 13, bottom: 9, trailing: 13))
                } else {
                    TextField("", text: $text)
                        .font(.formTextField)
                        .frame(height: 26)
                        .foregroundColor(.mainForeground)
                        .padding(EdgeInsets(top: 9, leading: 13, bottom: 9, trailing: 13))
                }
            }
            .background(Color.mainBackground)
            .modifier(RoundedEdge(width: 1, color: .fieldBorder, cornerRadius: .fieldCornerRadius))
        }
    }
}

struct FormTextField_Previews: PreviewProvider {
    @State static var email: String = "Preview"
    
    static var previews: some View {
        FormTextField(label: "E-mail", text: $email)
            .padding()
    }
}
