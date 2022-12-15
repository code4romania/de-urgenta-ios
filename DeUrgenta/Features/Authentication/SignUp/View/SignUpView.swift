import SwiftUI

struct SignUpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Creaza-ti contul") // localization
                    .customFont(.IBMPlexSansSemiBold, size: 23)
                    .padding(.bottom, 10)

                SignUpFormView()

                Spacer()

                CustomDividerView(label: AppStrings.dividerLabel.localized())
                    .padding(.vertical, 40)

                ProvidersView()
            }
            .padding()
            .navigationBarHidden(false)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
