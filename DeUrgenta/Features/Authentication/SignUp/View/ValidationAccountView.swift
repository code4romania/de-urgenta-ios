import SwiftUI

struct ValidationAccountView: View {
    var body: some View {
        VStack {
            HStack {
                Image("icon-envelope-large")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 100)

            Text(AppStrings.ValidationAccount.headerTitle.localized())
                .foregroundColor(.darkText)
                .customFont(.IBMPlexSansBold, size: 36)
                .padding(.vertical)

            Text(AppStrings.ValidationAccount.description.localized())
                .foregroundColor(.darkText)
                .customFont(size: 16)
                .lineSpacing(5)
                .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}
