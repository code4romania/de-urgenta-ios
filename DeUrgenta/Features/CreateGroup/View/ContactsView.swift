import SwiftUI

struct ContactsView: View {
    @StateObject var viewModel = CreateGroupViewModel()

    @State var searchText: String = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.horizontal)
            Spacer()

            ZStack {
                ScrollView {
                    ForEach(viewModel.contacts, id: \.id) { contact in
                        ContactRow(contact: contact)
                    }
                    .padding(.horizontal)
                }

                VStack {
                    Spacer()

                    Button(action: {
                        // requestAccess()
                    }, label: {
                        HStack {
                            Text(AppStrings.GroupView.addFriendsButton.localized())
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

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
