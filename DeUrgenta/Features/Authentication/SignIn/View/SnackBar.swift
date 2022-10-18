import SwiftUI

struct SnackBar: View {
    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)

                    Text("Parola ta a fost schimbata")
                        .customFont(.IBMPlexSansMedium, size: 14)
                }
                .padding(.bottom, 5)

                Text("Autentifica-te cu noua parola mai jos.")
                    .foregroundColor(.gray)
                    .customFont(size: 14)
            }
            .padding(.vertical)
            Spacer()
        }
        .frame(width: 335, height: 78)
    }
}
