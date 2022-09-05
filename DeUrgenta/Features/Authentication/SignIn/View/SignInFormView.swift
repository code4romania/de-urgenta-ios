import SwiftUI

struct SignInFormView: View {
    @ObservedObject var viewModel: SignInViewModel

    var body: some View {
        VStack(alignment: .leading) {
            InputFieldView(label: "Email",
                           fieldData: $viewModel.email,
                           showError: $viewModel.showEmailError)

            InputFieldView(label: "Password",
                           fieldData: $viewModel.password,
                           showError: $viewModel.showPasswordError)

            Button(action: {
                // TODO: Implement this action
            }, label: {
                VStack {
                    Text("Ti-ai uitat parola?")
                        .foregroundColor(.accent)
                        .customFont(size: 14)
                }
            })

            VStack {
                Button(action: {
                    // TODO: Implement sign in action
                }, label: {
                    HStack {
                        Text("Intra in contul tau")
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)
                })
            }
        }
    }
}
