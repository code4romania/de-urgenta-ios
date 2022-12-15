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
        let viewController = UIHostingController(rootView: SignUpView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SignUpCoordinator: SignUpViewDelegate {
    func signUpViewDidTapSignUp(_: SignUpView) {
        let viewController = UIHostingController(rootView: ValidationAccountView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
