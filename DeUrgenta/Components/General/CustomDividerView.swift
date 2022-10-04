import SwiftUI

struct CustomDividerView: View {
    var label: String

    var body: some View {
        HStack {
            Rectangle().fill(Color.gray.opacity(0.5)).frame(maxWidth: .infinity, maxHeight: 1)
            Text(label)
                .foregroundColor(.gray)
                .customFont(size: 14)
            Rectangle().fill(Color.gray.opacity(0.5)).frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}

struct CustomDividerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDividerView(label: "sau")
    }
}
