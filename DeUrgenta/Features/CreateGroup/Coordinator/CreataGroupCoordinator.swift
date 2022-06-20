
import Foundation
import SwiftUI
import UIKit

final class CreateGroupCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: CreateGroupView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
