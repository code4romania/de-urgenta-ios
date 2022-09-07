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
    case dividerLabel

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
        case alertTitle = "GroupView.alertTitle"
        case alertMessage = "GroupView.alertMessage"
        case alertPrimaryButton = "GroupView.alertPrimaryButton"
        case alertCloseButton = "GroupView.alertCloseButton"
    }

    enum ContactsView: String, Localizable {
        case inviteFriendsButton = "ContactsView.inviteFriendsButton"
    }

    enum ContactRow: String, Localizable {
        case buttonText = "ContactRow.buttonText"
        case alertTitle = "ConteactRow.alertTitle"
        case alertMessage = "ContactRow.alertMessage"
        case alertDismissButton = "ContactRow.alertDismissButton"
    }

    enum SearchBar: String, Localizable {
        case textFieldPlaceholder = "SearchBar.textFieldPlaceholder"
    }

    enum InvitedContactsView: String, Localizable {
        case addGroupMemberButton = "InvitedContactsView.addGroupMemberButton"
        case continueButton = "InvitedContactsView.continueButton"
    }

    enum InvitedContactsRow: String, Localizable {
        case invitationSentText = "InvitedContactsRow.invitationSentText"
        case removeContactText = "InvitedContactsRow.removeContactText"
    }

    enum AddItemSection: String, Localizable {
        case addNameLabel = "AddItemSection.addNameLabel"
        case addNamePlaceholder = "AddItemSection.addNamePlaceholder"
        case quantityLabel = "AddItemSection.quantityLabel"
        case quantityPlaceholder = "AddItemSelection.quantityPlaceholder"
        case expirationDateLabel = "AddItemSection.expirationDateLabel"
    }

    enum EmergencyBackpackView: String, Localizable {
        case headerTitle = "EmergencyBackpackView.headerTitle"
        case description = "EmergencyBackpackView.description"
        case addBackpackButton = "EmergencyBackpackView.addBackpackButton"
        case remindMeLaterButton = "EmergencyBackpackView.remindMeLaterButton"
    }

    enum MyBackpackView: String, Localizable {
        case headerTitle = "MyBackpackView.headerTitle"
        case firstParagraph = "MyBackpackView.firstParagraph"
        case secondParagraph = "MyBackpackView.secondParagraph"
        case addManagerButton = "MyBackpackView.addManagerButton"
        case backpackitemsHeader = "MyBackpackView.backpackitemsHeader"
    }

    enum CategoryItem: String, Localizable {
        case foodTitle = "CategoryItem.foodTitle"
        case hygieneItemsTitle = "CategoryItem.hygieneItemsTitle"
        case firstAidKitTitle = "CategoryItem.firstAidKitTitle"
        case docsTitle = "CategoryItem.docsTitle"
        case survivalItemsTitle = "CategoryItem.survivalItemsTitle"
        case mixedTitle = "CategoryItem.mixedTitle"
    }

    enum CategoryView: String, Localizable {
        case addItemButton = "CategoryView.addItemButton"
        case saveItemButton = "CategoryView.saveItemButton"
        case alertTitle = "CategoryView.alertTitle"
        case alertMessage = "CategoryView.alertMessage"
        case alertButton = "CategoryView.alertButton"
    }

    enum ItemView: String, Localizable {
        case deleteButton = "ItemView.deleteButton"
        case expirationDateLabel = "ItemView.expirationDateLabel"
    }

    enum AddNewManagerView: String, Localizable {
        case headerTitle = "AddNewManagerView.headerTitle"
        case firstParagraph = "AddNewManagerView.firstParagraph"
        case secondParagraph = "AddNewManagerView.secondParagraph"
        case toggleLabel = "AddNewManagerView.toggleLabel"
        case addManagerHeader = "AddNewManagerView.addManagerHeader"
        case addManagerButton = "AddNewManagerView.addManagerButton"
    }

    enum BackpackContactsView: String, Localizable {
        case alertMessageText = "BackpackContactsView.alertMessageText"
    }

    enum FirstAidIntroView: String, Localizable {
        case headerTitle = "FirstAidIntroView.headerTitle"
        case firstParagraph = "FirstAidIntroView.firstParagraph"
        case secondParagraph = "FirstAidIntroView.secondParagraph"
        case thirdParagraph = "FirstAidIntroView.thirdParagraph"
        case viewCoursesButton = "FirstAidIntroView.viewCoursesButton"
    }

    enum SelectCourseAndCityView: String, Localizable {
        case headerTitle = "SelectCourseAndCityView.headerTitle"
        case firstSelectorheader = "SelectCourseAndCityView.firstSelectorheader"
        case secondSelectorheader = "SelectCourseAndCityView.secondSelectorheader"
        case viewCoursesButton = "SelectCourseAndCityView.viewCoursesButton"
    }

    enum MenuView: String, Localizable {
        case addressLabel = "MenuView.adresslabel"
        case groupsLabel = "MenuView.groupsLabel"
        case backpackLabel = "MenuView.backpackLabel"
        case coursedLabel = "MenuView.coursedLabel"
        case myaccountLabel = "MenuView.myaccountLabel"
        case settingsLabel = "MenuView.settingsLabel"
        case aboutLabel = "MenuView.aboutLabel"
        case signoutLabel = "MenuView.signoutLabel"
        case headerIconLabel = "MenuView.headerIconLabel"
        case donateButtonText = "MenuView.donateButtonText"
    }

    enum TermsView: String, Localizable {
        case headerText = "TermsView.headerText"
        case headerTitle = "TermsView.headerTitle"
    }

    enum SettingsView: String, Localizable {
        case headerTitle = "SettingsView.headerTitle"
        case changePasswordText = "SettingsView.changePasswordText"
        case termsText = "SettingsView.termsText"
        case problemReportText = "SettingsView.problemReportText"
        case deleteAccount = "SettingsView.deleteAccountText"
    }

    enum AboutView: String, Localizable {
        case headerTitle = "AboutView.headerTitle"
        case logoText = "AboutView.logoText"
        case headerIconText = "AboutView.headerIconText"
        case donateButtonText = "AboutView.donateButtonText"
    }

    enum Authentication: String, Localizable {
        case signInHeaderTitle = "Authentication.signInHeaderTitle"
        case signInForgotPasswordLabel = "Authentication.signInForgotPasswordLabel"
        case signInButtonTitle = "Authentication.signInButtonTitle"

        enum Email: String, Localizable {
            case inputLabel = "Authentication.Email.inputLabel"
        }

        enum Password: String, Localizable {
            case inputLabel = "Authentication.Password.inputLabel"
            case invalidMessage = "Authentication.Password.invalidMessage"
        }

        enum Providers: String, Localizable {
            case appleLabel = "Authentication.Providers.appleLabel"
            case googleLabel = "Authentication.Providers.googleLabel"
            case facebookLabel = "Authentication.Providers.facebookLabel"
        }
    }
}
