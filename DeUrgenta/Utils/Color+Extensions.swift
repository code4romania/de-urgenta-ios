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

    static var fieldBorder: Color {
        Color("FieldBorder")
    }

    static var buttonBlue: Color {
        Color("buttonBlue")
    }

    static var buttonLightBlue: Color {
        Color("buttonLightBlue")
    }

    var uiColor: UIColor {
        UIColor(self)
    }

    var cgColor: CGColor {
        uiColor.cgColor
    }
}
