import SwiftUI

struct InvitedContactRow: View {
    var contact: ContactInfo
    @ObservedObject var viewModel: CreateGroupViewModel

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 60)

                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Text("\(contact.firstName) \(contact.lastName)")
                            .customFont(size: 16)

                        Text(AppStrings.InvitedContactsRow.invitationSentText.localized())
                            .customFont(size: 16)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Button(action: {
                        viewModel.removeContact(withItem: contact)
                    }, label: {
                        HStack {
                            Image(systemName: "xmark")
                                .foregroundColor(.accent)

                            Text(AppStrings.InvitedContactsRow.removeContactText.localized())
                                .customFont(size: 16)
                        }
                    })
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.vertical)

            Divider()
        }
    }
}
