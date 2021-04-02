//
//  AppFonts.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit

class AppFont {
    
    static func font(withFamilyStr familyString: String?,
                     styleStr: String?,
                     size: CGFloat = 10) -> UIFont? {
        return font(withFamily: AppFontFamily(rawValue: familyString ?? ""),
                    style: AppFontStyle(rawValue: styleStr ?? ""),
                    size: size)
    }

    private static func font(withFamily family: AppFontFamily?,
                             style: AppFontStyle?,
                             size: CGFloat) -> UIFont? {
        guard let style = style else { return nil }
        guard let name = family?.fullName(withStyle: style) else {
            return UIFont.systemFont(ofSize: size)
        }
        return UIFont(name: name, size: size)
    }
}

enum AppFontFamily: String {
    case main = ""
    
    func baseName() -> String {
        switch self {
        case .main:
            return "IBMPlexSans"
        }
    }
    
    func fullName(withStyle style: AppFontStyle) -> String {
        if style.fontName().isEmpty {
            // some regular fonts might not have "regular" as part of the name
            return baseName()
        }
        return baseName() + "-" + style.fontName()
    }
}

enum AppFontStyle: String {
    case bold
    case medium
    case regular
    
    func fontName() -> String {
        switch self {
        case .bold:
            return "Bold"
        case .medium:
            return "Medium"
        case .regular:
            return "Regular"
        }
    }
}

enum AppFontSize: String {
    case large
    case medium
    case normal
    case small
    case xsmall
    
    func size() -> CGFloat {
        switch self {
        case .large:
            return 30
        case .medium:
            return 28
        case .normal:
            return 20
        case .small:
            return 18
        case .xsmall:
            return 16
        }
    }
}

enum AppFontPreset: String {
    case largeTitle
    case title
    case smallTitle
    case subtitle
    case smallSubtitle
    case body
    case largeButton
    
    func font() -> UIFont? {
        switch self {
        case .largeTitle:
            return UIFont(name: AppFontFamily.main.fullName(withStyle: .medium), size: AppFontSize.large.size())
        case .title:
            return UIFont(name: AppFontFamily.main.fullName(withStyle: .medium), size: AppFontSize.medium.size())
        case .smallTitle:
            return UIFont(name: AppFontFamily.main.fullName(withStyle: .medium), size: AppFontSize.small.size())
        case .subtitle:
            return UIFont(name: AppFontFamily.main.fullName(withStyle: .regular), size: AppFontSize.normal.size())
        case .smallSubtitle:
            return UIFont(name: AppFontFamily.main.fullName(withStyle: .regular), size: AppFontSize.small.size())
        case .body:
            return UIFont(name: AppFontFamily.main.fullName(withStyle: .regular), size: AppFontSize.xsmall.size())
        case .largeButton:
            return UIFont(name: AppFontFamily.main.fullName(withStyle: .medium), size: AppFontSize.medium.size())
        }
    }
}

protocol StandardTextElement {
    var fontFamily: String? { set get }
    var fontStyle: String? { set get }
    func updateAppearanceWithFont(_ font: UIFont?)
}
