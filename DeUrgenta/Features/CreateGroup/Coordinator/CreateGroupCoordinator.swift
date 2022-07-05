import Foundation
import MessageUI
import SwiftUI
import UIKit

final class CreateGroupCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var currentContact: ContactInfo?
    @Published var invitedContacts: [ContactInfo] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: CreateGroupView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func presentMessageCompose(withItem contact: ContactInfo) {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        currentContact = contact

        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        var tempArray: [String] = []
        tempArray.append(contact.phoneNumber?.stringValue ?? "")
        composeVC.recipients = tempArray
        composeVC.body = "Prietena ta Corina Dobre te invita sa te alaturi grupului ei de prieteni pregatiti! Descarcă DeUrgenta de la http://deurgenta.ro/invite/d9a84aed5c39bc"

        navigationController.present(composeVC, animated: true)
    }
}

extension CreateGroupCoordinator: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .sent:
            if let currentContact = currentContact {
                invitedContacts.append(currentContact)
            }
        default:
            break
        }
        navigationController.dismiss(animated: true)
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
        let viewController = UIHostingController(rootView: SetMeetPointsView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension CreateGroupCoordinator: SetMeetPointsViewDelegate {
    func setMeetPointsViewDidTapInviteFriends(_: SetMeetPointsView) {
        let viewController = UIHostingController(rootView: GroupView(delegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension CreateGroupCoordinator: GroupViewDelegate {
    func groupViewDidTapAddFriendsButton(_: GroupView) {
        let viewController = UIHostingController(rootView: ContactsView(delegate: self, contactDelegate: self))
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension CreateGroupCoordinator: ContactRowDelegate {
    func contactRowDidTapAddButton(from _: ContactRow, withItem contact: ContactInfo) {
        presentMessageCompose(withItem: contact)
    }
}

extension CreateGroupCoordinator: ContactsViewDelegate {
    func contactsViewDidTapContinueButton(_: ContactsView) {
        let veiwController = UIHostingController(rootView: InvitedContactsView(invitedContacts: invitedContacts, delegate: self))
        navigationController.pushViewController(veiwController, animated: true)
    }
}

extension CreateGroupCoordinator: InvitedContactsViewDelegate {
    func invitedContactsViewDidTapAddMemberButton(_: InvitedContactsView) {
        navigationController.popViewController(animated: true)
    }

    func invitedContactsViewDidTapContinueButton(_: InvitedContactsView) {
        navigationController.popToRootViewController(animated: true)
    }
}
