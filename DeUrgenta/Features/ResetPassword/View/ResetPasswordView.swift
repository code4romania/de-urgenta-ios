import SwiftUI

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.Authentication.signInForgotPasswordLabel.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.bottom)

                Spacer()
            }

            VStack(alignment: .leading) {
                InputFieldView(label: "Email", fieldData: $viewModel.email, showError: $viewModel.showEmailError)
            }

            Spacer()

            VStack {
                Button(action: {
                    guard viewModel.isValidEmail() else {
                        return
                    }
                    // self.delegate.signInFormViewDidTapSignIn(self)
                }, label: {
                    HStack {
                        Text("Reseteaza-ti parola")
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)
                })
            }
        }
        .padding(.horizontal)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
