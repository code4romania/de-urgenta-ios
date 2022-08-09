import Foundation
import SwiftUI

final class SettingsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var viewModel: SettingsViewModel = .init()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: SettingsView(viewModel: viewModel, delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SettingsCoordinator: SettingsViewDelegate {
    func settingsViewShouldRedirect(from _: SettingsView, withItem item: SettingsOption) {
        switch item.settingsType {
        case .changePassword:
            break
        case .terms:
            let viewController = UIHostingController(rootView: EmptyView())
            navigationController.pushViewController(viewController, animated: true)
        case .problemReport:
            break
        case .deleteAccount:
            break
        }
    }
}
