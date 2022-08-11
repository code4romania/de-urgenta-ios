import SwiftUI

struct DonateButtonView: View {
    var body: some View {
        HStack {
            Text(AppStrings.AboutView.donateButtonText.localized())
                .foregroundColor(.secondary)
                .customFont(.IBMPlexSansBold, size: 16)
                .padding(.vertical)
        }
        .frame(maxWidth: 200, maxHeight: 50)
        .background(Color.green)
        .cornerRadius(6)
    }
}
