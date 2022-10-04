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
            InputFieldView(label: AppStrings.Authentication.Email.inputLabel.localized(),
                           errorMessage: viewModel.errorMessaageEmail,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.email,
                           showError: $viewModel.showEmailError)

            InputFieldView(label: AppStrings.Authentication.Password.inputLabel.localized(),
                           isSecureField: true,
                           errorMessage: viewModel.errorMessaagePassword,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.password,
                           showError: $viewModel.showPasswordError)

            Button(action: {
                self.delegate.signInFormViewDidTapForgotPassword(self)
            }, label: {
                VStack {
                    Text(AppStrings.Authentication.signInForgotPasswordLabel.localized())
                        .foregroundColor(.accent)
                        .customFont(size: 14)
                }
            })

            VStack {
                Button(action: {
                    let isValidEmail = viewModel.isValidEmail()
                    let isValidPassword = viewModel.isValidPassword()

                    guard isValidEmail,
                          isValidPassword
                    else {
                        return
                    }

                    self.delegate.signInFormViewDidTapSignIn(self)
                }, label: {
                    HStack {
                        Text(AppStrings.Authentication.signInButtonTitle.localized())
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)
                })
            }
        }
        .onChange(of: viewModel.email) { _ in
            self.viewModel.showEmailError = false
        }
        .onChange(of: viewModel.password) { _ in
            self.viewModel.showPasswordError = false
        }
    }
}
