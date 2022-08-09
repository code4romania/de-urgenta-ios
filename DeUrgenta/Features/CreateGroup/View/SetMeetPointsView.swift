import SwiftUI

protocol SetMeetPointsViewDelegate {
    func setMeetPointsViewDidTapInviteFriends(_ view: SetMeetPointsView)
}

struct SetMeetPointsView: View {
    @State var showMeetPoints = false
    var delegate: SetMeetPointsViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.SetMeetPoints.headerTitle.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.top, 10)

                Spacer()
            }
            .padding(.bottom, 20)

            Text(AppStrings.SetMeetPoints.description.localized())
                .customFont(size: 16)
                .foregroundColor(.darkText)
                .lineSpacing(10)

            Toggle(isOn: $showMeetPoints, label: {
                Text(AppStrings.SetMeetPoints.toggleLabel.localized())
                    .customFont(.IBMPlexSansBold, size: 16)
                    .foregroundColor(.black)
            })
            .padding(.vertical)

            HStack {
                Text(AppStrings.SetMeetPoints.meetPointsHeader.localized())
                    .customFont(.IBMPlexSansSemiBold, size: 23)

                Spacer()
            }
            .padding(.vertical)

            Divider()

            Button(action: {
                // TODO: Implement this action
            }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle.fill")

                    Text(AppStrings.SetMeetPoints.newMeetPointLablel.localized())
                        .foregroundColor(.accent)
                        .customFont(size: 18)
                        .padding(.leading, 10)
                        .padding(.trailing, 15)

                    Image(systemName: "chevron.right")
                    Spacer()
                }
                .foregroundColor(.accent)
                .padding(.vertical)
            })

            Divider()
            Spacer()

            Button(action: {
                delegate.setMeetPointsViewDidTapInviteFriends(self)
            }, label: {
                HStack {
                    Text(AppStrings.SetMeetPoints.inviteFriendsButton.localized())
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
    }
}
