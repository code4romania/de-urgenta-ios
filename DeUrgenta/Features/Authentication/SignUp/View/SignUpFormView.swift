
import SwiftUI

struct SignUpFormView: View {
    @StateObject var viewModel = SignUpViewModel()
    @State var isChecked = false
    @State var showAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            InputFieldView(label: "Prenume", // localization
                           errorMessage: "",
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.firstnama,
                           showError: $viewModel.showEmailError) // need to be changed

            InputFieldView(label: "Nume", // localization
                           errorMessage: "",
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.lastname,
                           showError: $viewModel.showEmailError) // need to be changed

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
                    guard isChecked else {
                        showAlert = true
                        return
                    }
                    // TODO: Implement this action
                }, label: {
                    HStack {
                        Text("Mai departe")
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
            Alert(title: Text("Atenție"),
                  message: Text("Trebuie să acceptați termenii și condițiile pentru a putea utiliza această aplicație."),
                  dismissButton: .default(Text(AppStrings.ContactRow.alertDismissButton.localized())))
        })
    }
}
