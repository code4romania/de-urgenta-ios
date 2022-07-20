import Foundation
import MessageUI
import SwiftUI
import UIKit

final class EmergencyBackpackCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var categoryViewModel: CategoryViewModel = .init()
    var contactsViewModel: CreateGroupViewModel = .init()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: EmergencyBackpackView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func presentMessageCompose(withItem contact: ContactInfo) {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        contactsViewModel.currentContact = contact

        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        composeVC.recipients = [contact.phoneNumber.stringValue]
        composeVC.body = "Prietena ta Corina Dobre te invita sa te alaturi grupului ei de prieteni pregatiti! Descarcă DeUrgenta de la http://deurgenta.ro/invite/d9a84aed5c39bc"

        navigationController.present(composeVC, animated: true)
    }
}

extension EmergencyBackpackCoordinator: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .sent:
            if let currentContact = contactsViewModel.currentContact {
                contactsViewModel.invitedContacts.append(currentContact)
            }
        default:
            break
        }
        navigationController.dismiss(animated: true)
    }
}

extension EmergencyBackpackCoordinator: EmergencyBackpackViewDelegate {
    func emergencyBackpackViewDidTapAddBackpack(_: EmergencyBackpackView) {
        let viewController = UIHostingController(rootView: MyBackpackView(categoryViewModel: categoryViewModel, delegate: self, myBackpackDelegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func emergencyBackpackViewDidTapRemindMeLater(_: EmergencyBackpackView) {
        navigationController.popViewController(animated: true)
    }
}

extension EmergencyBackpackCoordinator: MyBackpackViewDelegate {
    func myBackpackViewDidTapAddManager(_: MyBackpackView) {
        let viewController = UIHostingController(rootView: AddNewManagerView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension EmergencyBackpackCoordinator: BackpackCategoryItemViewDelegate {
    func backpackCategoryItemViewDidTapButton(from _: BackpackCategoryItemView, withItem item: CategoryItem) {
        let viewController = UIHostingController(rootView: CategoryView(categoryViewModel: CategoryViewModel(selectedCategory: item)))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension EmergencyBackpackCoordinator: AddNewManagerViewDelegate {
    func addNewManagerViewDidTapAddManager(_: AddNewManagerView) {
        let viewController = UIHostingController(rootView: EmptyView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
