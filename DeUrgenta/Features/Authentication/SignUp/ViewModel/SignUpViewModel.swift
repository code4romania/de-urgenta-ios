import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var firstnama: String = ""
    @Published var lastname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var errorMessageEmail: String = ""
    @Published var errorMessagePassword: String = ""
    @Published var showEmailError: Bool = false
    @Published var showPasswordError: Bool = false

    @Published var areTermsAndConditionsAccepted: Bool = false
}
