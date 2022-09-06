import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Autentifica-te")
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .padding(.bottom, 10)

            SignInFormView(viewModel: viewModel)

            CustomDividerView(label: "sau")
                .padding(.vertical, 40)

            ProvidersView()

            Spacer()
        }
        .padding()
    }
}
