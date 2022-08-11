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

struct SocialMediaIconsView: View {
    var body: some View {
        HStack {
            Image("facebook-icon")
                .frame(width: 24, height: 24)
                .padding()
            
            Image("instagram-icon")
                .frame(width: 24, height: 24)
                .padding()
            
            Image("link-icon")
                .frame(width: 24, height: 24)
                .padding()
            
            Image("github-icon")
                .frame(width: 24, height: 24)
                .padding()
        }
    }
}

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
