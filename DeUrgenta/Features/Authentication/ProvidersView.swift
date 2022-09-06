import SwiftUI

struct ProvidersView: View {
    // TODO: Implement providers buttons and actions.
    var body: some View {
        VStack(spacing: 24) {
            Button(action: {
                // TODO: Implement sign in with apple.
            }, label: {
                HStack {
                    Image("apple-icon")
                    Text("Autentifica-te cu Apple")
                        .foregroundColor(.white)
                        .customFont(.IBMPlexSansSemiBold, size: 14)
                }
                .frame(maxWidth: .infinity, maxHeight: 38)
                .background(Color.black)
                .cornerRadius(6)
            })

            Button(action: {
                // TODO: Implement sign in with google.
            }, label: {
                HStack {
                    Image("google-icon")
                    Text("Autentifica-te cu Google")
                        .foregroundColor(.white)
                        .customFont(.IBMPlexSansSemiBold, size: 14)
                }
                .frame(maxWidth: .infinity, maxHeight: 38)
                .background(Color.lightBlue)
                .cornerRadius(6)
            })

            Button(action: {
                // TODO: Implement sign in with facebook.
            }, label: {
                HStack {
                    Image("facebook-auth-icon")
                    Text("Autentifica-te cu Facebook")
                        .foregroundColor(.white)
                        .customFont(.IBMPlexSansSemiBold, size: 14)
                }
                .frame(maxWidth: .infinity, maxHeight: 38)
                .background(Color.blue)
                .cornerRadius(6)
            })
        }
    }
}
