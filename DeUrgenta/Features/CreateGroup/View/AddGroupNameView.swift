import SwiftUI

protocol AddGroupNameViewDelegate {
    func addGroupNameViewDidTapContinue(_ view: AddGroupNameView)
}

struct AddGroupNameView: View {
    @State private var groupName: String = ""
    @State private var showingAlert = false
    var delegate: AddGroupNameViewDelegate

    var body: some View {
        VStack {
            HStack {
                Text(AppStrings.AddGroupName.headerTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.top, 10)

                Spacer()
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text(AppStrings.AddGroupName.textFieldTitle.localized())
                    .customFont(size: 14)

                TextField(AppStrings.AddGroupName.textFieldPlaceholder.localized(), text: $groupName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()

            Spacer()

            VStack {
                Button(action: {
                    if groupName.isEmpty {
                        showingAlert = true
                    } else {
                        delegate.addGroupNameViewDidTapContinue(self)
                    }

                }, label: {
                    HStack {
                        Text(AppStrings.AddGroupName.continueButton.localized())
                            .foregroundColor(.secondary)
                            .customFont(.IBMPlexSansBold, size: 16)

                        Image(systemName: "arrow.right")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.accent)
                    .cornerRadius(6)
                })
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(AppStrings.AddGroupName.alertTitle.localized()), message: Text(AppStrings.AddGroupName.alertMessage.localized()), dismissButton: .default(Text(AppStrings.AddGroupName.alertDismissButton.localized())))
            })
            .padding(.bottom, 30)
            .padding(.horizontal)
        }
    }
}
