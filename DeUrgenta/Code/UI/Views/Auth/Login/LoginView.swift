//
//  LoginView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 4) {
            VStack(spacing: .defaultVerticalSpacing) {
                FormTextField(label: "E-mail", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                FormTextField(label: "Parola", text: $viewModel.password, isSecure: true)
            }
            
            VStack(spacing: 4) {
                Button(action: {
                    print("tapped")
                }, label: {
                    HStack {
                        Text("Ti-ai uitat parola?")
                            .foregroundColor(.accent)
                            .font(.formTextField)
                        
                        Spacer()
                    }
                })
                .frame(height: 50)
                
                renderButton()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Autentifică-te")
        
        NavigationLink(
            destination: HomeView(),
            isActive: $viewModel.isLoggedIn,
            label: {
                EmptyView()
            })
    }
    
    private func renderButton() -> some View {
        Button(action: {
            self.viewModel.submit()
        }, label: {
            Text("Intra in contul tau")
                .frame(maxWidth: .infinity)
        })
        .buttonStyle(
            LargeButton(
                bgColor: .accent,
                fgColor: .mainBackground))
        .alert(isPresented: $viewModel.isError, content: {
            Alert(
                title: Text("Ups!"),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("Ok")))
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
        
    }
}
