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
                            .font(.custom("IBMPlexSans-Regular", size: 16))
                            .foregroundColor(.darkText)

                        Text(AppStrings.InvitedContactsRow.invitationSentText.localized())
                            .font(.custom("IBMPlexSans-Regular", size: 16))
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
                                .font(.custom("IBMPlexSans-Regular", size: 16))
                                .foregroundColor(.darkText)
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
