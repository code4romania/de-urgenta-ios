import Foundation
import SwiftUI
import UIKit

final class CreateGroupCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: CreateGroupView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension CreateGroupCoordinator: CreateGroupViewDelegate {
    func createGroupViewDidTapAddGroup(_: CreateGroupView) {
        let viewController = UIHostingController(rootView: AddGroupNameView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func createGroupViewDidTapNoGroup(_: CreateGroupView) {
        navigationController.popViewController(animated: true)
    }
}

extension CreateGroupCoordinator: AddGroupNameViewDelegate {
    func addGroupNameViewDidTapContinue(_: AddGroupNameView) {
        let viewController = UIHostingController(rootView: EmptyView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
