import Foundation
import SwiftUI

extension View {
    func customFont(_ name: IBMPlexSansFonts = .IBMPlexSansRegular, size: CGFloat) -> some View {
        modifier(CustomFont(name: name, size: size))
    }

    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }

    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
