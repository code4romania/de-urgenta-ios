import SwiftUI

protocol SignInViewDelegate {
    func signInViewDidTapSignIn(_ view: SignInView)
    func signInViewDidTapForgotPassword(_ view: SignInView)
}

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    var delegate: SignInViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            Text("Autentifica-te")
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .padding(.bottom, 10)

            SignInFormView(viewModel: viewModel, delegate: self)

            CustomDividerView(label: "sau")
                .padding(.vertical, 40)

            ProvidersView()

            Spacer()
        }
        .padding()
    }
}

extension SignInView: SignInFormViewDelegate {
    func signInFormViewDidTapSignIn(_: SignInFormView) {
        delegate.signInViewDidTapSignIn(self)
    }

    func signInFormViewDidTapForgotPassword(_: SignInFormView) {
        delegate.signInViewDidTapForgotPassword(self)
    }
}
