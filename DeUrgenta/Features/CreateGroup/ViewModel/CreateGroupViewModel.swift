import Contacts
import Foundation

class CreateGroupViewModel: ObservableObject {
    @Published var contacts = [ContactInfo]()

    init() {}

    func fetchingContacts() {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try CNContactStore().enumerateContacts(with: request, usingBlock: { contact, _ in
                self.contacts.append(ContactInfo(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value))
            })
        } catch {
            print("Failed", error)
        }
    }
}
