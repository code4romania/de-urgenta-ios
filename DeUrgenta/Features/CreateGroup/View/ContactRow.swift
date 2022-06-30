import SwiftUI

struct ContactRow: View {
    var contact: ContactInfo
    var body: some View {
        Text("\(contact.firstName) \(contact.lastName)")
    }
}
