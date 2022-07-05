import MessageUI
import SwiftUI

protocol ContactRowDelegate {
    func contactRowDidTapAddButton(from view: ContactRow, withItem contact: ContactInfo)
}

struct ContactRow: View {
    var contact: ContactInfo
    var delegate: ContactRowDelegate

    @ObservedObject var viewModel: CreateGroupViewModel
    @State var showingAlert = false

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading) {
                    Text("\(contact.firstName) \(contact.lastName)")
                        .font(.custom("IBMPlexSans-Regular", size: 15))
                        .foregroundColor(.darkText)

                    Text("\(contact.phoneNumber?.stringValue ?? "")")
                        .font(.custom("IBMPlexSans-Regular", size: 15))
                        .foregroundColor(.gray)
                }
                .lineSpacing(2)

                Spacer()

                Button(action: {
                    if viewModel.invitedContacts.contains(where: { $0.id == contact.id }) {
                        showingAlert = true
                        print("Trimis deja")
                    } else {
                        delegate.contactRowDidTapAddButton(from: self, withItem: contact)
                    }

                }, label: {
                    Text(AppStrings.ContactRow.buttonText.localized())
                        .foregroundColor(Color.accent)
                        .padding(.bottom, 2)
                        .padding(.top, 2)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.accent, lineWidth: 1)
                        )
                })
            }
            .padding(.vertical)
            .padding(.trailing, 2)
            .frame(height: 50)
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(AppStrings.AddGroupName.alertTitle.localized()), message: Text("Ati trimis deja o invitatie catre \(contact.firstName) \(contact.lastName)"), dismissButton: .default(Text(AppStrings.AddGroupName.alertDismissButton.localized())))
            })

            Divider()
        }
    }
}
