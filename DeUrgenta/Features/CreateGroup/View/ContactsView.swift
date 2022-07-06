import SwiftUI

protocol ContactsViewDelegate {
    func contactsViewDidTapContinueButton(_ view: ContactsView)
}

struct ContactsView: View {
    @ObservedObject var viewModel: CreateGroupViewModel
    @State var searchText: String = ""

    var delegate: ContactRowDelegate
    var contactDelegate: ContactsViewDelegate

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
                        ContactRow(viewModel: viewModel, contact: contact, delegate: delegate)
                    }
                    .padding(.horizontal)
                }

                VStack {
                    Button(action: {
                        contactDelegate.contactsViewDidTapContinueButton(self)
                    }, label: {
                        HStack {
                            Text(AppStrings.ContactsView.inviteFriendsButton.localized())
                                .font(.custom("IBMPlexSans-Bold", size: 16))
                                .foregroundColor(.secondary)

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
