import Foundation

final class SettingsViewModel {
    let settingsOptions = [
        SettingsOption(name: "Schimbă parola", settingsType: .changePassword),
        SettingsOption(name: "Termeni și condiții", settingsType: .terms),
        SettingsOption(name: "Raportează o problemă", settingsType: .problemReport),
        SettingsOption(name: "Șterge contul", settingsType: .deleteAccount),
    ]
}
