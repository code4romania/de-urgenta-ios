import SwiftUI

struct SpinnerView: View {
    var body: some View {
        HStack {
            Spacer()

            ZStack {
                Text(AppStrings.AboutView.logoText.localized())
                    .foregroundColor(.white)
                    .customFont(.IBMPlexSansSemiBold, size: 24)
                    .zIndex(1)

                Image("spinner-large")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            }

            Spacer()
        }
    }
}
