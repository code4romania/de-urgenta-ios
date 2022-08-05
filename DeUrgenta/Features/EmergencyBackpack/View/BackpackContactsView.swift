import SwiftUI

protocol BackpackContactsViewDelegate {
    func backpackContactsViewDidTapContinueButton(_ view: BackpackContactsView)
}

struct BackpackContactsView: View {
    @ObservedObject var viewModel: ContactsViewModel
    @State var searchText: String = ""

    var contactRowDelegate: BackpackContactRowDelegate
    var contactsViewDelegate: BackpackContactsViewDelegate

    var filtredContacts: [ContactInfo] {
        var contactsArrayCopy: [ContactInfo] = viewModel.contacts
        guard searchText.isEmpty else {
            let filtredItems = viewModel.contacts.filter {
                $0.firstName.uppercased().contains(searchText.uppercased()) ||
                    $0.lastName.uppercased().contains(searchText.uppercased())
            }
            contactsArrayCopy = filtredItems
            return contactsArrayCopy
        }
        return viewModel.contacts
    }

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.horizontal)
                .background(Color.accent)

            Spacer()

            ZStack(alignment: .bottom) {
                ScrollView {
                    ForEach(filtredContacts, id: \.id) { contact in
                        BackpackContactRow(viewModel: viewModel, contact: contact, delegate: contactRowDelegate)
                    }
                    .padding(.horizontal)
                }

                VStack {
                    Button(action: {
                        contactsViewDelegate.backpackContactsViewDidTapContinueButton(self)
                    }, label: {
                        HStack {
                            Text("Continuă")
                                .foregroundColor(.secondary)
                                .customFont(.IBMPlexSansBold, size: 16)

                            Image(systemName: "arrow.right")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.accent)
                        .cornerRadius(6)
                    })
                }
                .frame(maxHeight: 50)
                .padding(.horizontal)
                .padding(.bottom, 30)
            }.onAppear {
                getContacts()
            }
        }
    }

    func getContacts() {
        DispatchQueue.main.async {
            if viewModel.contacts.isEmpty {
                viewModel.fetchingContacts()
            }
        }
    }
}
