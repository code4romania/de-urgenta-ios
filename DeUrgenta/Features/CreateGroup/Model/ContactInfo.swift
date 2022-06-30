import Contacts
import Foundation

struct ContactInfo: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var phoneNumber: CNPhoneNumber?
}
