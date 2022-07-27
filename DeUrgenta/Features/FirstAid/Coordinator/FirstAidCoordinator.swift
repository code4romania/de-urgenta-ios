import Foundation
import SwiftUI
import UIKit

final class FirstAidCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var locationManager = LocationViewModel()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: FirstAidIntroView(locationManager: locationManager, delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension FirstAidCoordinator: FirstAidIntroViewDelegate {
    func firstAidIntroViewDidTapButton(_: FirstAidIntroView) {
        let viewController = UIHostingController(rootView: SelectCourseAndCityView(locationManager: locationManager))
        navigationController.pushViewController(viewController, animated: true)
    }
}
