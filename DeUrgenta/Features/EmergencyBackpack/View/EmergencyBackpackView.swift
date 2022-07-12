import SwiftUI

protocol EmergencyBackpackViewDelegate {
    func emergencyBackpackViewDidTapAddBackpack(_ view: EmergencyBackpackView)
    func emergencyBackpackViewDidTapRemindMeLater(_ view: EmergencyBackpackView)
}

struct EmergencyBackpackView: View {
    var delegate: EmergencyBackpackViewDelegate

    var body: some View {
        VStack(alignment: .leading) {
            Text(AppStrings.EmergencyBackpackView.headerTitle.localized())
                .font(.custom("IBMPlexSans-SemiBold", size: 23))
                .padding(.top, 10)

            ScrollView {
                Text(AppStrings.EmergencyBackpackView.description.localized())
                    .font(.custom("IBMPlexSans-Regular", size: 16))
                    .foregroundColor(.darkText)
                    .lineSpacing(10)
                    .padding(.vertical, 10)

                Divider()
                    .padding(.top, 10)

                Button(action: {
                    delegate.emergencyBackpackViewDidTapAddBackpack(self)
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)

                        Text(AppStrings.EmergencyBackpackView.addBackpackButton.localized())
                            .font(.custom("IBMPlexSans-SemiBold", size: 20))
                            .foregroundColor(.darkText)
                    }
                    .padding(.vertical)

                    Spacer()

                    Image("chevron-right")
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                })

                Divider()
            }

            Spacer()

            HStack {
                Spacer()

                Button(action: {
                    delegate.emergencyBackpackViewDidTapRemindMeLater(self)
                }, label: {
                    Text(AppStrings.EmergencyBackpackView.remindMeLaterButton.localized())
                        .foregroundColor(.gray)
                        .underline()
                })

                Spacer()
            }
            .padding(.bottom, 45)
        }
        .padding(.horizontal)
    }
}
