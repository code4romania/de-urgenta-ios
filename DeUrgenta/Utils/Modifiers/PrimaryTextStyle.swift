import SwiftUI

struct PrimaryTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("IBMPlexSans-Regular", size: 16))
            .foregroundColor(.darkText)
    }
}
