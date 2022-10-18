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
                Text("Schimba-ti parola")
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.bottom)

                Spacer()
            }

            InputFieldView(label: "Parola noua",
                           isSecureField: true,
                           errorMessage: viewModel.errorMessaagePassword,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.password,
                           showError: $viewModel.showPasswordError)
                .padding(.bottom)

            InputFieldView(label: "Confirma parola noua",
                           isSecureField: true,
                           errorMessage: viewModel.errorMessaagePassword,
                           iconName: "exclamationmark.circle.fill",
                           fieldData: $viewModel.confirmationPassword,
                           showError: $viewModel.showPasswordError)

            Spacer()

            VStack {
                Button(action: {
                    guard viewModel.checkNewPassword() else {
                        return
                    }
                    delegate.insertNewPasswordViewDidTapSave(self)
                }, label: {
                    HStack {
                        Text("Salveaza parola")
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
            self.viewModel.showPasswordError = false
        }
    }
}
