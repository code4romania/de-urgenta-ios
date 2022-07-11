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
    func landingPageCoordinatorShouldPresentRoutes(_ sender: LandingPageCoordinator) {
        let coordinator = AccountConfigCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func landingPageCoordinatorShouldPresentSignIn(_: LandingPageCoordinator) {
        // TODO: Implement this method
    }

    func landingPageCoordinatorShouldPresentSignUp(_: LandingPageCoordinator) {
        // TODO: Implement this method
    }
}

extension ApplicationCoordinator: AccountConfigCoordinatorDelegate {
    func accountConfigCoordinatorShouldPresentAdress(_: AccountConfigCoordinator) {
        // TODO: Implement this method
    }

    func accountConfigCoordinatorShouldPresentGroup(_ sender: AccountConfigCoordinator) {
        let coordinator = CreateGroupCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func accountConfigCoordinatorShouldPresentBackpack(_ sender: AccountConfigCoordinator) {
        let coordinator = EmergencyBackpackCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        // coordinator.delegate = self
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func accountConfigCoordinatorShouldPresentFirstAid(_: AccountConfigCoordinator) {
        // TODO: Implement this method
    }
}
