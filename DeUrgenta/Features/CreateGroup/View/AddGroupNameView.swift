import SwiftUI

protocol AddGroupNameViewDelegate {
    func addGroupNameViewDidTapContinue(_ view: AddGroupNameView)
}

struct AddGroupNameView: View {
    @State private var groupName: String = ""

    var delegate: AddGroupNameViewDelegate

    var body: some View {
        VStack {
            HStack {
                Text(AppStrings.AddGroupName.headerTitle.localized())
                    .font(.custom("IBMPlexSans-SemiBold", size: 24))

                Spacer()
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text(AppStrings.AddGroupName.textFieldTitle.localized())
                    .foregroundColor(Color.darkText)
                    .font(.custom("IBMPlexSans-Regular", size: 14))

                TextField("Fii creativ...", text: $groupName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()

            Spacer()

            VStack {
                Button(action: {
                    delegate.addGroupNameViewDidTapContinue(self)
                }, label: {
                    HStack {
                        Text(AppStrings.AddGroupName.continueButton.localized())
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
            .padding(.bottom, 30)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
    }
}
