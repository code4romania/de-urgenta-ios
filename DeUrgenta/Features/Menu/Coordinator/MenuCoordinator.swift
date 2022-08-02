import Foundation
import SwiftUI
import UIKit

final class MenuCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var viewModel: MenuViewModel = .init()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: MenuView(viewModel: viewModel))
        navigationController.pushViewController(viewController, animated: true)
    }
}
