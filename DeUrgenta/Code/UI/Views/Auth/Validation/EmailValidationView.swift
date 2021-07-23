//
//  EmailValidationView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.07.2021.
//

import SwiftUI

struct EmailValidationView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 60)
            
            HStack {
                Image.envelopeIconLarge
                    .frame(width: 57, height: 43)
                Spacer()
            }

            Spacer()
                .frame(height: 44)

            HStack {
                BigTitleLabel(title: "Validează-ți contul")
                Spacer()
            }

            Spacer()
                .frame(height: 20)

            HStack {
                BodyTextLabel(text: "Un e-mail a fost trimis catre adresa pe care ti-ai facut contul bla bla te rugam sa apesi linkul pt validarea contului etc.")
                Spacer()
            }

            Spacer()
        }
        .foregroundColor(.regularText)
        .padding()
        .navigationBarHidden(true)
    }
}

struct EmailValidationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmailValidationView()
        }
    }
}
