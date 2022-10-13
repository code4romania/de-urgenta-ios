import Foundation

final class ResetPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var showEmailError: Bool = false
    @Published var errorMessaageEmail: String = ""

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
}
