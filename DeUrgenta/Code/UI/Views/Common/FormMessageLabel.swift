//
//  FormMessageLabel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import SwiftUI

struct FormMessageLabel: View {
    let message: String
    var isSuccess = true
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image.checkmark
            
            Text(message)
                .font(.formMessage)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .foregroundColor(isSuccess ? .successTitle : .errorTitle)
    }
}

struct FormMessageLabel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack(spacing: 50) {
                FormMessageLabel(message: "Adresa ta de domiciliu a fost salvata cu succes.", isSuccess: true)
                
                FormMessageLabel(message: "Contul tau a fost validat.", isSuccess: true)

            }
        }
        .padding()
    }
}
