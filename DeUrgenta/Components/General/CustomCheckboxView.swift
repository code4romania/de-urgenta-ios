import SwiftUI

struct CustomCheckboxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    isChecked = !isChecked
                }, label: {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .foregroundColor(Color.red)
                })

                Spacer()
            }

            Text(AppStrings.CustomCheckbox.description.localized())
                .foregroundColor(.darkText)
                .customFont(size: 16)
        }
    }
}
