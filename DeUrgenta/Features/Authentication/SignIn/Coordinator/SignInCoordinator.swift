import Foundation
import SwiftUI
import UIKit

final class SignInCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var signInViewModel = SignInViewModel()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: SignInView(viewModel: signInViewModel, delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SignInCoordinator: SignInViewDelegate, ResetPasswordViewDelegate, InsertNewPasswordViewDelegate {
    func signInViewDidTapSignIn(_: SignInView) {
        // TODO: Implement this action
    }

    func signInViewDidTapForgotPassword(_: SignInView) {
        let viewController = UIHostingController(rootView: ResetPasswordView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func resetPasswordViewDidTapReset(_: ResetPasswordView, for _: String) {
        let viewController = UIHostingController(rootView: InsertNewPasswordView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func insertNewPasswordViewDidTapSave(_: InsertNewPasswordView) {
        let viewControllers: [UIViewController] = navigationController.viewControllers as [UIViewController]
        navigationController.popToViewController(viewControllers[viewControllers.count - 3], animated: true)

        signInViewModel.isPresented = true
    }
}
