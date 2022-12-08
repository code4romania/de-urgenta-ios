import Foundation
import SwiftUI
import UIKit

final class SignUpCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: SignUpView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
