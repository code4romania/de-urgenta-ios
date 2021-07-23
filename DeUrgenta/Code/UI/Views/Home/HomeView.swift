//
//  HomeView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.homeBackground.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {}, label: {
                        HStack(spacing: 10) {
                            Text("Vezi trasee")
                            Image.map
                        }
                    })
                    .buttonStyle(SmallButton(bgColor: .homeForeground, fgColor: .homeBackground))
                    
                }
                .frame(height: 38)

                Spacer()
                
                VStack(spacing: 50.0) {
                    Image("white-logo")
                    
                    Text("Tu ți-ai făcut planul în caz de urgență?")
                        .font(.homeLarge)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                    .frame(height: 69)
                
                VStack(spacing: 24.0) {
                    NavigationLink(
                        destination: RegisterView(),
                        label: {
                            Text("Înscrie-te acum")
                                .frame(maxWidth: .infinity)
                        })
                        .buttonStyle(LargeButton(bgColor: .homeForeground, fgColor: .homeBackground))
                        .frame(maxWidth: .infinity)

                    NavigationLink(
                        destination: LoginView(),
                        label: {
                            Text("Autentifică-te")
                                .frame(maxWidth: .infinity)
                        })
                        .buttonStyle(LargeButton(bgColor: .clear, fgColor: .homeForeground))
                }
                
            }
            .foregroundColor(.homeForeground)
            .padding(.main)
            .frame(maxWidth: .infinity)
            .navigationBarHidden(true)
//            .preferredColorScheme(.dark)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
