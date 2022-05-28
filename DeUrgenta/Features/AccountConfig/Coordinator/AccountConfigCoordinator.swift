import Foundation
import SwiftUI
import UIKit

final class AccountConfigCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func start() {
        let viewController = UIHostingController(rootView: AccountConfigView())
        navigationController.setViewControllers([viewController], animated: false)
    }
}
