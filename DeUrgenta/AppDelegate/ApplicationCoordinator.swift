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
        showLandingPage()
    }

    private func showLandingPage() {
        let landingPageCoordinator = LandingPageCoordinator(navigationController: navigationController)
        addChildCoordinator(landingPageCoordinator)
        landingPageCoordinator.delegate = self
        landingPageCoordinator.start()
    }
}

extension ApplicationCoordinator: LandingPageCoordinatorDelegate {
    func landingPageCoordinatorShouldPresentRoutes(_: LandingPageCoordinator) {
        let viewController = UIHostingController(rootView: ContentView())
        navigationController.pushViewController(viewController, animated: true)
    }

    func landingPageCoordinatorShouldPresentSignIn(_: LandingPageCoordinator) {
        // TODO: Implement this method
    }

    func landingPageCoordinatorShouldPresentSignUp(_: LandingPageCoordinator) {
        // TODO: Implement this method
    }
}
