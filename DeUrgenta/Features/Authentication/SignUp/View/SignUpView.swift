import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Creaza-ti contul")
                .customFont(.IBMPlexSansSemiBold, size: 23)
                .padding(.bottom, 10)

            SignUpFormView()

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(false)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
