import SwiftUI

struct AddMemberButtonView: View {
    var body: some View {
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

                Text(AppStrings.InvitedContactsView.addGroupMemberButton.localized())
                    .foregroundColor(.accent)
                    .customFont(.IBMPlexSansSemiBold, size: 18)

                Spacer()
            }
            .padding(.vertical)

            Divider()
                .padding(.horizontal)
        }
    }
}
