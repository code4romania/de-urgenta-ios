import SwiftUI

protocol InsertNewPasswordViewDelegate {
    func insertNewPasswordViewDidTapSave(_ view: InsertNewPasswordView)
}

struct InsertNewPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
    var delegate: InsertNewPasswordViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.ForgotPassword.insertNewPasswordTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.bottom)

                Spacer()
            }

            InputFieldView(label: AppStrings.ForgotPassword.newPasswordLabel.localized(),
                           isSecureField: true,
                           errorMessage: viewModel.errorMessaagePassword,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.password,
                           showError: $viewModel.showPasswordError)
                .padding(.bottom)

            InputFieldView(label: AppStrings.ForgotPassword.confirmationPasswordLabel.localized(),
                           isSecureField: true,
                           errorMessage: viewModel.errorMessaageConfirmationPassword,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.confirmationPassword,
                           showError: $viewModel.showConfirmationPasswordError)

            Spacer()

            VStack {
                Button(action: {
                    guard viewModel.checkPasswordLength(), viewModel.checkConfirmationPasswordLength(), viewModel.checkPasswords() else {
                        return
                    }
                    delegate.insertNewPasswordViewDidTapSave(self)
                }, label: {
                    HStack {
                        Text(AppStrings.ForgotPassword.saveButtonTitle.localized())
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
        .onChange(of: viewModel.password) { _ in
            self.viewModel.showPasswordError = false
        }
        .onChange(of: viewModel.confirmationPassword) { _ in
            self.viewModel.showConfirmationPasswordError = false
            self.viewModel.showPasswordError = false
        }
    }
}
