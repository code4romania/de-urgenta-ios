//
//  RegisterView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 22.07.2021.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 4) {
            VStack(spacing: .defaultVerticalSpacing) {
                FormTextField(label: "Prenume", text: $viewModel.firstName)
                    .keyboardType(.default)
                    .autocapitalization(.words)

                FormTextField(label: "Nume", text: $viewModel.lastName)
                    .keyboardType(.default)
                    .autocapitalization(.words)

                FormTextField(label: "E-mail", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                FormTextField(label: "Parola", text: $viewModel.password, isSecure: true)
            }
            
            VStack(spacing: 4) {
                
                HStack(alignment: .top, spacing: 12) {
                    Button(action: {
                        self.viewModel.isTermsAgreed.toggle()
                    }, label: {
                        Image(systemName: viewModel.isTermsAgreed ? "square.fill" : "square")
                            .foregroundColor(.accent)
                            .frame(width: 16, height: 16, alignment: .center)
                            .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                        
                    })

                    self.generateAgreementLabel()
                    
                    Spacer()
                }
                .foregroundColor(.regularText)
                .padding(EdgeInsets(top: 24, leading: 0, bottom: 12, trailing: 0))

                generateContinueButton()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Creează-ți contul")
        .standardNavigationAppearance()

        NavigationLink(
            destination: HomeView(),
            isActive: $viewModel.isSuccess,
            label: {
                EmptyView()
            })
    }
    
    func openURL() {
        UIApplication.shared.openURL(URL(string: "https://code4.ro")!)
    }
    
    func generateCheckbox() -> some View {
        $viewModel.isTermsAgreed.wrappedValue ?
            Image.checkboxChecked :
            Image.checkboxUnchecked
    }
    
    func generateAgreementLabel() -> some View {
        return (Text("Sunt de acord cu ")
        + Text("termenii si conditiile")
            .foregroundColor(.accent)
        + Text(" acestei aplicatii De Urgenta."))
    }
    
    func generateContinueButton() -> some View {
        Button(action: {
            self.viewModel.submit()
        }, label: {
            HStack {
                Text("Mai departe")
                
                Image(systemName: "arrow.right")
            }
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
        .disabled(viewModel.isTermsAgreed)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
        }
    }
}
