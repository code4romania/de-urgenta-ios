import SwiftUI

protocol InvitedContactsViewDelegate {
    func invitedContactsViewDidTapAddMemberButton(_ view: InvitedContactsView)
    func invitedContactsViewDidTapContinueButton(_ view: InvitedContactsView)
}

struct InvitedContactsView: View {
    var delegate: InvitedContactsViewDelegate

    @ObservedObject var viewModel: CreateGroupViewModel

    var body: some View {
        VStack {
            HStack {
                Text(AppStrings.GroupView.headerTitle.localized()) // Localize text
                    .font(.custom("IBMPlexSans-SemiBold", size: 23))
                    .padding(.top, 10)

                Spacer()
            }
            .padding(.horizontal)

            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.accent)

                Text("Avengers32 (5/30)")
                    .font(.custom("IBMPlexSans-SemiBold", size: 20))

                Spacer()
            }
            .padding()

            ScrollView {
                ForEach(viewModel.invitedContacts, id: \.id) { contact in
                    InvitedContactRow(contact: contact, viewModel: viewModel)
                }
                .padding(.horizontal)

                Button(action: {
                    delegate.invitedContactsViewDidTapAddMemberButton(self)
                }, label: {
                    VStack {
                        HStack {
                            ZStack {
                                Image("logo")
                                    .resizable()
                                    .frame(width: 60, height: 60)

                                Image(systemName: "person.fill.badge.plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)

                            Text("Adauga membru nou in grup") // Localize text
                                .bold()
                                .foregroundColor(.accent)

                            Spacer()
                        }
                        .padding(.vertical)

                        Divider()
                            .padding(.horizontal)
                    }

                })
            }

            Spacer()

            Button(action: {
                delegate.invitedContactsViewDidTapContinueButton(self)
            }, label: {
                HStack {
                    Text(AppStrings.GroupView.addFriendsButton.localized()) // Localize text
                        .font(.custom("IBMPlexSans-Bold", size: 16))
                        .foregroundColor(.secondary)

                    Image(systemName: "arrow.right")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.accent)
                .cornerRadius(6)
            })
            .padding(.bottom, 30)
            .padding(.horizontal)
        }
    }
}
