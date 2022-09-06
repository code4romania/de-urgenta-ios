import SwiftUI

protocol SignInFormViewDelegate {
    func signInFormViewDidTapSignIn(_ view: SignInFormView)
    func signInFormViewDidTapForgotPassword(_ view: SignInFormView)
}

struct SignInFormView: View {
    @ObservedObject var viewModel: SignInViewModel
    var delegate: SignInFormViewDelegate

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            InputFieldView(label: "Email",
                           fieldData: $viewModel.email,
                           showError: $viewModel.showEmailError)

            InputFieldView(label: "Parola",
                           fieldData: $viewModel.password,
                           showError: $viewModel.showPasswordError)

            Button(action: {
                self.delegate.signInFormViewDidTapForgotPassword(self)
            }, label: {
                VStack {
                    Text("Ti-ai uitat parola?")
                        .foregroundColor(.accent)
                        .customFont(size: 14)
                }
            })

            VStack {
                Button(action: {
                    guard viewModel.isValidEmail(),
                          viewModel.isValidPassword()
                    else {
                        return
                    }

                    self.delegate.signInFormViewDidTapSignIn(self)
                }, label: {
                    HStack {
                        Text("Intra in contul tau")
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)
                })
            }
        }
    }
}
