import Foundation

protocol Localizable: RawRepresentable {
    func localized() -> String
}

extension Localizable {
    func localized() -> String {
        if let string = rawValue as? String {
            return string.localized()
        }

        return ""
    }
}

extension String {
    func localized(bundle _: Bundle = .main, tableName: String = "Localizable") -> String {
        NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

enum AppStrings: String, Localizable {
    case dummy = ""
    case cancel

    enum LandingPage: String, Localizable {
        case tagLine = "LandingPage.tagLine"
        case authenticate = "LandingPage.authenticate"
        case createAccount = "LandingPage.createAccount"
        case viewRoutes = "LandingPage.viewRoutes"
    }

    enum AccountConfig: String, Localizable {
        case headerTitle = "AccountConfig.headerTitle"
    }

    enum CreateGroup: String, Localizable {
        case headerTitle = "CreateGroup.headerTitle"
        case firstParagraph = "CreateGroup.firstParagraph"
        case secondParagraph = "CreateGroup.secondParagraph"
        case noGroup = "CreateGroup.noGroup"
        case addGroup = "CreateGroup.addGroup"
    }

    enum AddGroupName: String, Localizable {
        case headerTitle = "AddGroupName.headerTitle"
        case textFieldTitle = "AddGroupName.textFieldTitle"
        case textFieldPlaceholder = "AddGroupName.textFieldPlaceholder"
        case continueButton = "AddGroupName.continueButton"
    }
}
