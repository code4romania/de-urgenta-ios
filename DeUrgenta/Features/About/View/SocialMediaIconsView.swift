import SwiftUI

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
