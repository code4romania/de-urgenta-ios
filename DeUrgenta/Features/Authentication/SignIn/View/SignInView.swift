import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Autentifica-te")
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .padding(.top, 10)

            SignInFormView(viewModel: viewModel)

            Spacer()
        }
        .padding()
    }
}
