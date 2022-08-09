import SwiftUI

protocol LandingPageViewDelegate {
    func landingPageViewDidTapSignIn(_ view: LandingPageView)
    func landingPageViewDidTapSignUp(_ view: LandingPageView)
    func landingPageViewDidTapRoutes(_ view: LandingPageView)
}

struct LandingPageView: View {
    var delegate: LandingPageViewDelegate

    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Spacer()

                    Button(action: {
                        delegate.landingPageViewDidTapRoutes(self)
                    }, label: {
                        HStack {
                            Text(AppStrings.LandingPage.viewRoutes.localized())
                                .foregroundColor(.accent)
                                .customFont(.IBMPlexSansSemiBold, size: 14)

                            Image("config.map-icon")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .foregroundColor(.accent)
                        .frame(width: 136, height: 38)
                        .background(Color.secondary)
                        .cornerRadius(6)
                    })
                }
                .padding(.trailing, 8)
                .padding(.top, 50)
                .padding(.bottom, 100)

                Spacer()

                Image("white-logo")
                    .resizable()
                    .frame(width: 100, height: 100)

                Text(AppStrings.LandingPage.tagLine.localized())
                    .foregroundColor(.lightText)
                    .customFont(.IBMPlexSansBold, size: 36)
                    .multilineTextAlignment(.center)
                    .padding(.top, 43)

                Spacer()

                Button(action: {
                    delegate.landingPageViewDidTapSignUp(self)
                }, label: {
                    Text(AppStrings.LandingPage.createAccount.localized())
                        .foregroundColor(.accent)
                        .customFont(.IBMPlexSansBold, size: 16)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary)
                        .cornerRadius(6)
                }).padding(.bottom, 36)

                Button(AppStrings.LandingPage.authenticate.localized()) {
                    delegate.landingPageViewDidTapSignIn(self)
                }.foregroundColor(.lightText)
                    .customFont(.IBMPlexSansBold, size: 16)
                    .padding(.bottom, 20)

            }.padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
    }
}
