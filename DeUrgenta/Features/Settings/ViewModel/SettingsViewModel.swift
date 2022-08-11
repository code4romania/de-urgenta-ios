import Foundation

final class SettingsViewModel {
    let settingsOptions = [
        SettingsOption(name: AppStrings.SettingsView.changePasswordText.localized(), settingsType: .changePassword),
        SettingsOption(name: AppStrings.SettingsView.termsText.localized(), settingsType: .terms),
        SettingsOption(name: AppStrings.SettingsView.problemReportText.localized(), settingsType: .problemReport),
        SettingsOption(name: AppStrings.SettingsView.deleteAccount.localized(), settingsType: .deleteAccount),
    ]
}
