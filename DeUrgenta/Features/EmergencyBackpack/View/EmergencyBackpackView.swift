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
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .padding(.top, 10)

            ScrollView {
                Text(AppStrings.EmergencyBackpackView.description.localized())
                    .customFont(size: 16)
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
                            .customFont(.IBMPlexSansSemiBold, size: 20)
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
