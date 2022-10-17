import Foundation

final class ResetPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmationPassword: String = ""
    @Published var showEmailError: Bool = false
    @Published var showPasswordError: Bool = false
    @Published var errorMessaageEmail: String = ""
    @Published var errorMessaagePassword: String = ""

    private let validator = Validator.shared

    func isValidEmail() -> Bool {
        do {
            return try validator.isValidData(data: email, type: .email)
        } catch ValidationError.empty {
            showEmailError = true
            errorMessaageEmail = AppStrings.Authentication.Error.emptyEmail.localized()
        } catch ValidationError.invalid {
            showEmailError = true
            errorMessaageEmail = AppStrings.Authentication.Error.invalidEmail.localized()
        } catch {
            return false
        }
        return false
    }

    func isValidPassword() -> Bool {
        do {
            return try validator.isValidData(data: password, type: .password)
        } catch ValidationError.empty {
            showPasswordError = true
            errorMessaagePassword = AppStrings.Authentication.Error.emptyPassword.localized()
        } catch ValidationError.invalid {
            showPasswordError = true
            errorMessaagePassword = AppStrings.Authentication.Error.invalidPassword.localized()
        } catch {
            return false
        }
        return false
    }

    func checkNewPassword() -> Bool {
        if password != confirmationPassword {
            showPasswordError = true
            errorMessaagePassword = "Parolele introduse nu corespund"
        }
        return password == confirmationPassword
    }
}
