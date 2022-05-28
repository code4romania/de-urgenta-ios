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

            VStack {
                Image("white-logo")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
        .navigationBarHidden(true)
    }
}
