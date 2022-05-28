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
                Image("white-logo")
                    .resizable()
                    .frame(width: 100, height: 100)

                Text(AppStrings.LandingPage.tagLine.localized())
                    .foregroundColor(.lightText)
                    .font(.custom("IBMPlexSans-Bold", size: 36))
                    .multilineTextAlignment(.center)
                    .padding(.top, 43)
            }.padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
    }
}
