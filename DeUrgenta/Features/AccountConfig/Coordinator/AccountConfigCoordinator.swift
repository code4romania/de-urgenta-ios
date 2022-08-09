import Foundation
import SwiftUI
import UIKit

protocol AccountConfigCoordinatorDelegate: AnyObject {
    func accountConfigCoordinatorShouldPresentAdress(_ coordinator: AccountConfigCoordinator)
    func accountConfigCoordinatorShouldPresentGroup(_ coordinator: AccountConfigCoordinator)
    func accountConfigCoordinatorShouldPresentBackpack(_ coordinator: AccountConfigCoordinator)
    func accountConfigCoordinatorShouldPresentFirstAid(_ coordintaor: AccountConfigCoordinator)
    func accountConfigCoordinatorShouldPresentMenu(_ coordinator: AccountConfigCoordinator)
}

final class AccountConfigCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    var delegate: AccountConfigCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func start() {
        let viewController = UIHostingController(rootView: AccountConfigView(delegate: self))
        navigationController.setViewControllers([viewController], animated: false)
    }
}

extension AccountConfigCoordinator: AccountConfigViewDelegate {
    func accountConfigViewDidTapMenuButton(_: AccountConfigView) {
        delegate?.accountConfigCoordinatorShouldPresentMenu(self)
    }

    func accountConfigViewShouldRedirect(from _: AccountConfigView, withItem item: ConfigStep) {
        switch item.type {
        case .adress:
            delegate?.accountConfigCoordinatorShouldPresentAdress(self)
        case .group:
            delegate?.accountConfigCoordinatorShouldPresentGroup(self)
        case .backpack:
            delegate?.accountConfigCoordinatorShouldPresentBackpack(self)
        case .firstAid:
            delegate?.accountConfigCoordinatorShouldPresentFirstAid(self)
        }
    }
}
