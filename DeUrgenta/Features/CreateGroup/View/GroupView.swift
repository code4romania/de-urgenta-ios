import Contacts
import SwiftUI

protocol GroupViewDelegate {
    func groupViewDidTapAddFriendsButton(_ view: GroupView)
}

struct GroupView: View {
    var delegate: GroupViewDelegate
    @State var showingAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.GroupView.headerTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.top, 10)

                Spacer()
            }

            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.accent)

                Text("Avengers32 (5/30)")
                    .customFont(.IBMPlexSansSemiBold, size: 20)

                Spacer()
            }
            .padding(.vertical)

            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 50, height: 50)

                Text("(Admin) Corina Dobre")
                    .customFont(size: 16)
                    .foregroundColor(.darkText)

                Spacer()
            }

            Spacer()

            Button(action: {
                requestAccess()
            }, label: {
                HStack {
                    Text(AppStrings.GroupView.addFriendsButton.localized())
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
        }
        .padding(.horizontal)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(AppStrings.GroupView.alertTitle.localized()),
                  message: Text(AppStrings.GroupView.alertMessage.localized()),
                  primaryButton: .default(Text(AppStrings.GroupView.alertPrimaryButton.localized()), action: {
                      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                  }),
                  secondaryButton: .default(Text(AppStrings.GroupView.alertCloseButton.localized())))
        }
    }

    func requestAccess() {
        CNContactStore().requestAccess(for: .contacts) { access, _ in
            if access {
                DispatchQueue.main.async {
                    delegate.groupViewDidTapAddFriendsButton(self)
                }
            } else {
                showingAlert.toggle()
            }
        }
    }
}
