
import SwiftUI

protocol SignUpFormViewDelegate {
    func signUpFormViewDidTapSignUp(_ view: SignUpFormView)
}

struct SignUpFormView: View {
    @StateObject var viewModel = SignUpViewModel()
    @State var isChecked = false
    @State var showAlert = false

    var delegate: SignUpFormViewDelegate

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            InputFieldView(label: AppStrings.Authentication.FirstName.inputLabel.localized(),
                           errorMessage: viewModel.errorMessageFirstName,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.firstName,
                           showError: $viewModel.showFirstNameError)

            InputFieldView(label: AppStrings.Authentication.LastName.inputLabel.localized(),
                           errorMessage: viewModel.errorMessageLastName,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.lastName,
                           showError: $viewModel.showLastNameError)

            InputFieldView(label: AppStrings.Authentication.Email.inputLabel.localized(),
                           errorMessage: viewModel.errorMessageEmail,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.email,
                           showError: $viewModel.showEmailError)

            InputFieldView(label: AppStrings.Authentication.Password.inputLabel.localized(),
                           isSecureField: true,
                           errorMessage: viewModel.errorMessagePassword,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.password,
                           showError: $viewModel.showPasswordError)

            CustomCheckboxView(isChecked: $isChecked)

            VStack {
                Button(action: {
                    let isValidFirstName = viewModel.isValidFirstName()
                    let isValidLastName = viewModel.isValidLastName()
                    let isValidEmail = viewModel.isValidEmail()
                    let isValidPassword = viewModel.isValidPassword()

                    guard isValidFirstName, isValidLastName, isValidEmail, isValidPassword else {
                        return
                    }

                    guard isChecked else {
                        showAlert = true
                        return
                    }

                    delegate.signUpFormViewDidTapSignUp(self)

                }, label: {
                    HStack {
                        Text(AppStrings.Authentication.signUpButtonTitle.localized())
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)

                        Image(systemName: "arrow.right")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)
                })
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(AppStrings.Authentication.Alert.headerTitle.localized()),
                  message: Text(AppStrings.Authentication.Alert.description.localized()),
                  dismissButton: .default(Text(AppStrings.ContactRow.alertDismissButton.localized())))
        })
        .onChange(of: viewModel.firstName) { _ in
            self.viewModel.showFirstNameError = false
        }
        .onChange(of: viewModel.lastName) { _ in
            self.viewModel.showLastNameError = false
        }
        .onChange(of: viewModel.email) { _ in
            self.viewModel.showEmailError = false
        }
        .onChange(of: viewModel.password) { _ in
            self.viewModel.showPasswordError = false
        }
    }
}
