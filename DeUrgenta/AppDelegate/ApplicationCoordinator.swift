import Foundation
import SwiftUI
import UIKit

final class ApplicationCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func start() {
        let viewController = UIHostingController(rootView: ContentView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
