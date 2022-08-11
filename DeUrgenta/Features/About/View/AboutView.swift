import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(AppStrings.AboutView.headerTitle.localized())
                    .customFont(.IBMPlexSansBold, size: 30)
                    .padding(.bottom, 15)

                Text("Aliquet nec orci mattis amet quisque ullamcorper neque, nibh sem. At arcu, sit dui mi, nibh dui, diam eget aliquam. Quisque id at vitae feugiat egestas ac. Diam nulla orci at in viverra scelerisque eget. Eleifend egestas fringilla sapien.")
                    .customFont(size: 16)
                    .lineSpacing(10)

                SpinnerView()

                Text("Aliquet nec orci mattis amet quisque ullamcorper neque, nibh sem. At arcu, sit dui mi, nibh dui, diam eget aliquam. Quisque id at vitae feugiat egestas ac. Diam nulla orci at in viverra scelerisque eget. Eleifend egestas fringilla sapien.")
                    .customFont(size: 16)
                    .lineSpacing(10)

                Divider()
                    .padding(.bottom, 15)

                HStack {
                    Spacer()

                    VStack {
                        Text(AppStrings.AboutView.headerIconText.localized())
                            .customFont(size: 14)
                            .padding(.bottom, 10)

                        Image("code4romania-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 165, height: 60)

                        SocialMediaIconsView()

                        Button(action: {
                            // TODO: Implement this action
                        }, label: {
                            DonateButtonView()
                        })
                        .padding(.bottom, 20)
                    }

                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }
}
