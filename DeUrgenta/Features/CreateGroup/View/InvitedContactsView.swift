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
                Text(AppStrings.GroupView.headerTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .foregroundColor(.darkText)
                    .padding(.top, 10)

                Spacer()
            }
            .padding(.horizontal)

            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.accent)

                Text("Avengers32 (5/30)")
                    .customFont(.IBMPlexSansSemiBold, size: 20)
                    .foregroundColor(.darkText)

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
                    AddMemberButtonView()
                })
            }

            Spacer()

            Button(action: {
                delegate.invitedContactsViewDidTapContinueButton(self)
            }, label: {
                HStack {
                    Text(AppStrings.InvitedContactsView.continueButton.localized())
                        .foregroundColor(.secondary)
                        .customFont(.IBMPlexSansBold, size: 16)

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
