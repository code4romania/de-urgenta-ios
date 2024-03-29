import SwiftUI

protocol SignInViewDelegate {
    func signInViewDidTapSignIn(_ view: SignInView)
    func signInViewDidTapForgotPassword(_ view: SignInView)
}

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    var delegate: SignInViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            Text(AppStrings.Authentication.signInHeaderTitle.localized())
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .padding(.bottom, 10)

            SignInFormView(viewModel: viewModel, delegate: self)

            CustomDividerView(label: AppStrings.dividerLabel.localized())
                .padding(.vertical, 40)

            ProvidersView()

            Spacer()
        }
        .padding()
        .navigationBarHidden(false)
        .modifier(Popup(isPresented: $viewModel.isPresented,
                        alignment: .top,
                        direction: .top,
                        popupContent: { SnackBar() }))
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
