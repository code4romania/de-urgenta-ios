import Foundation
import SwiftUI
import UIKit

protocol MenuCoordinatorDelegate: AnyObject {
    func menuCoordinatorShouldPresentAdress(_ coordinator: MenuCoordinator)
    func menuCoordinatorShouldPresentGroups(_ coordinator: MenuCoordinator)
    func menuCoordinatorShouldPresentBackpack(_ coordinator: MenuCoordinator)
    func menuCoordinatorShouldPresentCourses(_ coordinator: MenuCoordinator)
    func menuCoordinatorShouldPresentMyAccount(_ coordinator: MenuCoordinator)
    func menuCoordinatorShouldPresentSettings(_ coordinator: MenuCoordinator)
    func menuCoordinatorShouldPresentAbout(_ coordinator: MenuCoordinator)
    func menuCoordinatorShouldPresentSignout(_ coordinator: MenuCoordinator)
}

final class MenuCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var viewModel: MenuViewModel = .init()
    var delegate: MenuCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: MenuView(viewModel: viewModel, delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MenuCoordinator: MenuViewDelegate {
    func menuViewDidTapDonateButton(_ view: MenuView) {
        // TODO: Implement this method
    }
    
    func menuViewShouldRedirect(from _: MenuView, withItem item: MenuOption) {
        switch item.type {
        case .adress:
            delegate?.menuCoordinatorShouldPresentAdress(self)
        case .grups:
            delegate?.menuCoordinatorShouldPresentGroups(self)
        case .backpack:
            delegate?.menuCoordinatorShouldPresentBackpack(self)
        case .courses:
            delegate?.menuCoordinatorShouldPresentCourses(self)
        case .myaccount:
            delegate?.menuCoordinatorShouldPresentMyAccount(self)
        case .settings:
            delegate?.menuCoordinatorShouldPresentSettings(self)
        case .about:
            delegate?.menuCoordinatorShouldPresentAbout(self)
        case .signout:
            delegate?.menuCoordinatorShouldPresentSignout(self)
        }
    }
}
