import Foundation
import SwiftUI
import UIKit

protocol LandingPageCoordinatorDelegate: AnyObject {
    func landingPageCoordinatorShouldPresentSignIn(_ coordinator: LandingPageCoordinator)
    func landingPageCoordinatorShouldPresentSignUp(_ coordinator: LandingPageCoordinator)
    func landingPageCoordinatorShouldPresentRoutes(_ coordinator: LandingPageCoordinator)
}

final class LandingPageCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var delegate: LandingPageCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func start() {
        let viewController = UIHostingController(rootView: LandingPageView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension LandingPageCoordinator: LandingPageViewDelegate {
    func landingPageViewDidTapRoutes(_: LandingPageView) {
        delegate?.landingPageCoordinatorShouldPresentRoutes(self)
    }

    func landingPageViewDidTapSignIn(_: LandingPageView) {
        delegate?.landingPageCoordinatorShouldPresentSignIn(self)
    }

    func landingPageViewDidTapSignUp(_: LandingPageView) {
        delegate?.landingPageCoordinatorShouldPresentSignUp(self)
    }
}
