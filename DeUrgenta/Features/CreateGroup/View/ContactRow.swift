import MessageUI
import SwiftUI

protocol ContactRowDelegate {
    func contactRowDidTapAddButton(from view: ContactRow, withItem contact: ContactInfo)
}

struct ContactRow: View {
    @ObservedObject var viewModel: CreateGroupViewModel
    @State var showingAlert = false

    var contact: ContactInfo
    var delegate: ContactRowDelegate

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading) {
                    Text("\(contact.firstName) \(contact.lastName)")
                        .customFont(size: 15)
                        .foregroundColor(.darkText)

                    Text("\(contact.phoneNumber.stringValue)")
                        .customFont(size: 15)
                        .foregroundColor(.gray)
                }
                .lineSpacing(2)

                Spacer()

                Button(action: {
                    if viewModel.invitedContacts.contains(where: { $0.id == contact.id }) {
                        showingAlert = true
                    } else {
                        delegate.contactRowDidTapAddButton(from: self, withItem: contact)
                    }

                }, label: {
                    Text(AppStrings.ContactRow.buttonText.localized())
                        .foregroundColor(Color.accent)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
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
                Alert(title: Text(AppStrings.ContactRow.alertTitle.localized()),
                      message: Text(AppStrings.ContactRow.alertMessage.localized() + contact.firstName + " " + contact.lastName),
                      dismissButton: .default(Text(AppStrings.ContactRow.alertDismissButton.localized())))
            })

            Divider()
        }
    }
}
