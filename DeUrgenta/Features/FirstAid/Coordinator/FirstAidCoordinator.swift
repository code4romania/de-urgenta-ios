import Foundation
import SwiftUI
import UIKit

final class FirstAidCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: FirstAidIntroView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
