import SwiftUI

struct SnackBar: View {
    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)

                    Text(AppStrings.SnackBar.headerTitle.localized())
                        .customFont(.IBMPlexSansMedium, size: 14)
                }
                .padding(.bottom, 5)

                Text(AppStrings.SnackBar.textInfo.localized())
                    .foregroundColor(.gray)
                    .customFont(size: 14)
            }
            .padding(.vertical)
            Spacer()
        }
        .frame(width: 335, height: 78)
    }
}
