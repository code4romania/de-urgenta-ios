import Foundation

enum SettingsOptionType {
    case changePassword
    case terms
    case problemReport
    case deleteAccount
}

struct SettingsOption: Hashable {
    var name: String
    var settingsType: SettingsOptionType
}
