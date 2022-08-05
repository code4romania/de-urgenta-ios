import SwiftUI

protocol BackpackContactRowDelegate {
    func backpackContactRowDidTapAddButton(from view: BackpackContactRow, withItem contact: ContactInfo)
}

struct BackpackContactRow: View {
    @ObservedObject var viewModel: ContactsViewModel
    @State var showingAlert = false

    var contact: ContactInfo
    var delegate: BackpackContactRowDelegate

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading) {
                    Text("\(contact.firstName) \(contact.lastName)")
                        .customFont(size: 15)

                    Text("\(contact.phoneNumber.stringValue)")
                        .foregroundColor(.gray)
                        .customFont(size: 15)
                }
                .lineSpacing(2)

                Spacer()

                Button(action: {
                    guard viewModel.invitedContactAsManager != nil else {
                        delegate.backpackContactRowDidTapAddButton(from: self, withItem: contact)
                        return
                    }

                    showingAlert = true
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
                      message: Text(AppStrings.ContactRow.alertMessage.localized() + viewModel.invitedContactAsManager!.firstName + " " + viewModel.invitedContactAsManager!.lastName + " " + AppStrings.BackpackContactsView.alertMessageText.localized()),
                      dismissButton: .default(Text(AppStrings.ContactRow.alertDismissButton.localized())))
            })

            Divider()
        }
    }
}
