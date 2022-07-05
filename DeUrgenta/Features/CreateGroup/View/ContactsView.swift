import SwiftUI

protocol ContactsViewDelegate {
    func contactsViewDidTapContinueButton(_ view: ContactsView)
}

struct ContactsView: View {
    @StateObject var viewModel = CreateGroupViewModel()

    @State var searchText: String = ""

    var delegate: ContactRowDelegate
    var contactDelegate: ContactsViewDelegate

    var filtredContacts: [ContactInfo] {
        var tempArray: [ContactInfo] = viewModel.contacts
        guard searchText.isEmpty else {
            let filtredItems = viewModel.contacts.filter {
                $0.firstName.uppercased().contains(searchText.uppercased()) ||
                    $0.lastName.uppercased().contains(searchText.uppercased())
            }
            tempArray = filtredItems
            return tempArray
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
                        ContactRow(contact: contact, delegate: delegate)
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
            viewModel.fetchingContacts()
        }
    }
}
