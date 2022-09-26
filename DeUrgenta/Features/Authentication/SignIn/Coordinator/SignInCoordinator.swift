import Foundation
import SwiftUI
import UIKit

final class SignInCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: SignInView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SignInCoordinator: SignInViewDelegate {
    func signInViewDidTapSignIn(_: SignInView) {
        // TODO: Implement this action
    }

    func signInViewDidTapForgotPassword(_: SignInView) {
        // TODO: Implement this action
    }
}
