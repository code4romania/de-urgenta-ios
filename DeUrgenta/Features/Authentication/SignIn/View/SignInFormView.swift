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
                           fieldData: $viewModel.email,
                           showError: $viewModel.showEmailError)

            InputFieldView(label: AppStrings.Authentication.Password.inputLabel.localized(),
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
                    guard viewModel.isValidEmail(),
                          viewModel.isValidPassword()
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
    }
}
