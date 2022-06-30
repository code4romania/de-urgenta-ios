import SwiftUI

struct ContactsView: View {
    @StateObject var viewModel = CreateGroupViewModel()

    var body: some View {
        List {
            ForEach(viewModel.contacts, id: \.id) { contact in
                ContactRow(contact: contact)
            }
        }
        .onAppear {
            getContacts()
        }
    }

    func getContacts() {
        DispatchQueue.main.async {
            viewModel.fetchingContacts()
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
