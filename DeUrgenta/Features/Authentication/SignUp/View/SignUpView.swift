import SwiftUI

protocol SignUpViewDelegate {
    func signUpViewDidTapSignUp(_ view: SignUpView)
}

struct SignUpView: View {
    var delegate: SignUpViewDelegate

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(AppStrings.Authentication.signUpHeaderTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.bottom, 10)

                SignUpFormView(delegate: self)

                Spacer()

                CustomDividerView(label: AppStrings.dividerLabel.localized())
                    .padding(.vertical, 40)

                ProvidersView()
            }
            .padding()
            .navigationBarHidden(false)
        }
    }
}

extension SignUpView: SignUpFormViewDelegate {
    func signUpFormViewDidTapSignUp(_: SignUpFormView) {
        delegate.signUpViewDidTapSignUp(self)
    }
}
