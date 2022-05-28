import Foundation
import SwiftUI

extension Color {
    static var accent: Color {
        Color("AccentColor")
    }

    static var secondary: Color {
        Color("HomeFG")
    }

    static var lightText: Color {
        Color("HomeFG")
    }

    var uiColor: UIColor {
        UIColor(self)
    }

    var cgColor: CGColor {
        uiColor.cgColor
    }
}
