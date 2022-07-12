import SwiftUI

struct ItemIcon: View {
    var iconName: String

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accent)
                .frame(width: 50, height: 50)

            Image(iconName)
        }
    }
}
