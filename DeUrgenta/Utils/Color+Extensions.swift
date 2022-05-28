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

    static var darkText: Color {
        Color("darkText")
    }

    var uiColor: UIColor {
        UIColor(self)
    }

    var cgColor: CGColor {
        uiColor.cgColor
    }
}
