import Foundation

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessaageEmail: String = ""
    @Published var errorMessaagePassword: String = ""
    @Published var showEmailError: Bool = false
    @Published var showPasswordError: Bool = false

    private let validator = Validator.shared

    func isValidEmail() -> Bool {
        showEmailError = false

        validator.isValidData(data: email, type: .email) { error in
            guard let error = error else {
                return
            }
            self.showEmailError = true

            switch error {
            case .empty:
                self.errorMessaageEmail = AppStrings.Authentication.Error.emptyEmail.localized()
            case .invalid:
                self.errorMessaageEmail = AppStrings.Authentication.Error.invalidEmail.localized()
            }
        }

        return !showEmailError
    }

    func isValidPassword() -> Bool {
        showPasswordError = false

        validator.isValidData(data: password, type: .password) { error in
            guard let error = error else {
                return
            }
            self.showPasswordError = true

            switch error {
            case .empty:
                self.errorMessaagePassword = AppStrings.Authentication.Error.emptyPassword.localized()
            case .invalid:
                self.errorMessaagePassword = AppStrings.Authentication.Error.invalidPassword.localized()
            }
        }

        return !showPasswordError
    }
}
