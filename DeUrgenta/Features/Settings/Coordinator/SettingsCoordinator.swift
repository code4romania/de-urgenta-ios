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
        let viewController = UIHostingController(rootView: SettingsView(viewModel: viewModel))
        navigationController.pushViewController(viewController, animated: true)
    }
}
