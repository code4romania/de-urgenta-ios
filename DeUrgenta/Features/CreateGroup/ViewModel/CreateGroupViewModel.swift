import Contacts
import Foundation

class CreateGroupViewModel: ObservableObject {
    @Published var contacts = [ContactInfo]()

    var currentContact: ContactInfo?
    @Published var invitedContacts: [ContactInfo] = []

    init() {}

    func fetchingContacts() {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try CNContactStore().enumerateContacts(with: request, usingBlock: { contact, _ in
                if let contactPhoneNumber = contact.phoneNumbers.first?.value {
                    self.contacts.append(ContactInfo(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contactPhoneNumber))
                }
            })
        } catch {
            print("Failed", error)
        }
        sortContacts()
    }

    func sortContacts() {
        contacts.sort {
            $0.firstName < $1.firstName
        }
    }

    func removeContact(withItem contact: ContactInfo) {
        invitedContacts = invitedContacts.filter { $0.id != contact.id }
    }
}
