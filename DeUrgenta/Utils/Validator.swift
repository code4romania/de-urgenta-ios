import Foundation

enum ValidationType {
    case email
    case password
}

class Validator {
    static let shared = Validator()

    private init() {}

    func isValidData(data: String, type: ValidationType) -> Bool {
        var regExPattern = ""

        switch type {
        case .email:
            regExPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            // At least 1 lowercase character 1 uppercase character and 1 number, minimum 8 characters, max 15 characters.
            regExPattern = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
        }

        let predicate = NSPredicate(format: "SELF MATCHES %@", regExPattern)
        return predicate.evaluate(with: data)
    }

    func isSameData(first: String, second: String) -> Bool {
        first == second
    }
}
