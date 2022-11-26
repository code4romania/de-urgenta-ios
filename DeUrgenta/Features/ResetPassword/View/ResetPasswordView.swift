import SwiftUI

protocol ResetPasswordViewDelegate {
    func resetPasswordViewDidTapReset(_ view: ResetPasswordView, for email: String)
}

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
    var delegate: ResetPasswordViewDelegate?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.Authentication.signInForgotPasswordLabel.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.bottom)

                Spacer()
            }

            VStack(alignment: .leading) {
                InputFieldView(label: AppStrings.Authentication.Email.inputLabel.localized(),
                               errorMessage: viewModel.errorMessaageEmail,
                               iconName: "exclamationmark.circle.fill",
                               fieldData: $viewModel.email,
                               showError: $viewModel.showEmailError)
            }

            Spacer()

            VStack {
                Button(action: {
                    guard viewModel.isValidEmail() else {
                        return
                    }
                    self.delegate?.resetPasswordViewDidTapReset(self, for: viewModel.email)
                }, label: {
                    HStack {
                        Text(AppStrings.ForgotPassword.resetButtonTitle.localized())
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)
                })
            }
        }
        .padding()
        .onChange(of: viewModel.email) { _ in
            self.viewModel.showEmailError = false
        }
    }
}
