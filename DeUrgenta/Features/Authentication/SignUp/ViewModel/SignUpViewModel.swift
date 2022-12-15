import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var errorMessageEmail: String = ""
    @Published var errorMessagePassword: String = ""
    @Published var showEmailError: Bool = false
    @Published var showPasswordError: Bool = false

    @Published var errorMessageFirstName: String = AppStrings.Authentication.Error.emptyFirstName.localized()
    @Published var errorMessageLastName: String = AppStrings.Authentication.Error.emptyLastName.localized()
    @Published var showFirstNameError: Bool = false
    @Published var showLastNameError: Bool = false

    @Published var areTermsAndConditionsAccepted: Bool = false

    private let validator = Validator.shared

    func isValidFirstName() -> Bool {
        if firstname.isEmpty {
            showFirstNameError = true
            return false
        }
        return true
    }

    func isValidLastName() -> Bool {
        if lastname.isEmpty {
            showLastNameError = true
            return false
        }
        return true
    }

    func isValidEmail() -> Bool {
        do {
            return try validator.isValidData(data: email, type: .email)
        } catch ValidationError.empty {
            showEmailError = true
            errorMessageEmail = AppStrings.Authentication.Error.emptyEmail.localized()
        } catch ValidationError.invalid {
            showEmailError = true
            errorMessageEmail = AppStrings.Authentication.Error.invalidEmail.localized()
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
            errorMessagePassword = AppStrings.Authentication.Error.emptyPassword.localized()
        } catch ValidationError.invalid {
            showPasswordError = true
            errorMessagePassword = AppStrings.Authentication.Error.invalidPassword.localized()
        } catch {
            return false
        }
        return false
    }
}
