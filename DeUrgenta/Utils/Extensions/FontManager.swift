import Foundation
import SwiftUI

enum IBMPlexSansFonts: String {
    case IBMPlexSansRegular = "IBMPlexSans-Regular"
    case IBMPlexSansMedium = "IBMPlexSans-Medium"
    case IBMPlexSansSemiBold = "IBMPlexSans-SemiBold"
    case IBMPlexSansBold = "IBMPlexSans-Bold"
}

struct CustomFont: ViewModifier {
    var name: IBMPlexSansFonts
    var size: CGFloat

    func body(content: Content) -> some View {
        content.font(Font.custom(name.rawValue, size: size))
            .foregroundColor(.darkText)
    }
}
