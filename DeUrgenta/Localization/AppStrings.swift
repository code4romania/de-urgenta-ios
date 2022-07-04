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
        case alertTitle = "AddGroupName.alertTitle"
        case alertMessage = "AddGroupName.alertMessage"
        case alertDismissButton = "AddGroupName.alertDismissButton"
    }

    enum SetMeetPoints: String, Localizable {
        case headerTitle = "SetMeetPoints.headerTitle"
        case description = "SetMeetPoints.description"
        case toggleLabel = "SetMeetPoints.toggleLabel"
        case meetPointsHeader = "SetMeetPoints.meetPointsHeader"
        case newMeetPointLablel = "SetMeetPoints.newMeetPointLabel"
        case inviteFriendsButton = "SetMeetPoints.inviteFriendsButton"
    }

    enum GroupView: String, Localizable {
        case headerTitle = "GroupView.headerTitle"
        case addFriendsButton = "GroupView.addFriendsButton"
    }

    enum ContactsView: String, Localizable {
        case inviteFriendsButton = "ContactsView.inviteFriendsButton"
    }

    enum ContactRow: String, Localizable {
        case buttonText = "ContactRow.buttonText"
    }

    enum SearchBar: String, Localizable {
        case textFieldPlaceholder = "SearchBar.textFieldPlaceholder"
    }
}
