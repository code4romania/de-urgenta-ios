import Contacts
import Foundation

class ContactsViewModel: ObservableObject {
    @Published var contacts = [ContactInfo]()
    @Published var invitedContacts: [ContactInfo] = []

    var currentContact: ContactInfo?

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
}
