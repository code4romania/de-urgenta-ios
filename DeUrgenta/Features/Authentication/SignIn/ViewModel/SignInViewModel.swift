import Foundation

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showEmailError: Bool = false
    @Published var showPasswordError: Bool = false
}
