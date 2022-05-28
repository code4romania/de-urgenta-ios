import SwiftUI

struct AccountConfigView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)

                Spacer()
            }

            Text(AppStrings.AccountConfig.headerTitle.localized())
                .foregroundColor(.darkText)
                .font(.custom("IBMPlexSans-Bold", size: 36))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.top, 30)

            Spacer()
        }.padding(.leading, 20)
    }
}
