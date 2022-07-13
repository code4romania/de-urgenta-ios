import Foundation
import SwiftUI
import UIKit

final class EmergencyBackpackCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: EmergencyBackpackView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension EmergencyBackpackCoordinator: EmergencyBackpackViewDelegate {
    func emergencyBackpackViewDidTapAddBackpack(_: EmergencyBackpackView) {
        let viewController = UIHostingController(rootView: MyBackpackView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func emergencyBackpackViewDidTapRemindMeLater(_: EmergencyBackpackView) {
        navigationController.popViewController(animated: true)
    }
}

extension EmergencyBackpackCoordinator: BackpackItemViewDelegate {
    func backpackItemViewDidTapButton(from _: BackpackItemView, withItem _: CategoryItem) {
        let viewController = UIHostingController(rootView: EmptyView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
