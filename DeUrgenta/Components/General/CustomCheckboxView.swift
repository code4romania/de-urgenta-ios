import SwiftUI

struct CustomCheckboxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    if isChecked {
                        isChecked = false
                    } else {
                        isChecked = true
                    }
                }, label: {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .foregroundColor(Color.red)
                })

                Spacer()
            }

            Text("Sunt de acord cu termenii si conditiile acestei aplicatii De Urgenta.") // neee to be localized
                .foregroundColor(.darkText)
                .customFont(size: 16)
        }
    }
}
