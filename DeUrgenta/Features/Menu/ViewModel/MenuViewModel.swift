import Foundation

class MenuViewModel: ObservableObject {
    let options = [
        MenuOption(name: AppStrings.MenuView.addressLabel.localized(), type: .adress),
        MenuOption(name: AppStrings.MenuView.groupsLabel.localized(), type: .grups),
        MenuOption(name: AppStrings.MenuView.backpackLabel.localized(), type: .backpack),
        MenuOption(name: AppStrings.MenuView.coursedLabel.localized(), type: .courses),
        MenuOption(name: AppStrings.MenuView.myaccountLabel.localized(), type: .myaccount),
        MenuOption(name: AppStrings.MenuView.settingsLabel.localized(), type: .settings),
        MenuOption(name: AppStrings.MenuView.aboutLabel.localized(), type: .about),
        MenuOption(name: AppStrings.MenuView.donateButtonText.localized(), type: .signout),
    ]
}
