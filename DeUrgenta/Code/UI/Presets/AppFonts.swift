//
//  AppFonts.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import Foundation
import SwiftUI

private let appFontName = "IBMPlexSans"
private let appFontMedium = appFontName + "-Medium"
private let appFontRegular = appFontName + "-Regular"
private let appFontBold = appFontName + "-Bold"

extension Font {
    static let homeLarge = Font.custom(appFontBold, size: 36)
    static let largeButton = Font.custom(appFontBold, size: 16)
    static let smallButton = Font.custom(appFontBold, size: 14)

    static let smallFormLabel = Font.custom(appFontRegular, size: 14)
    static let formTextField = Font.custom(appFontRegular, size: 16)
    static let formMessage = Font.custom(appFontBold, size: 20)

    static let appLargeTitle = Font.custom(appFontBold, size: 24)
    static let appTitle = Font.custom(appFontBold, size: 20)
    static let appBody = Font.custom(appFontRegular, size: 16)

    static let largeTitle = Font.custom(appFontBold, size: 24)
    static let title = Font.custom(appFontBold, size: 20)
    static let body = Font.custom(appFontRegular, size: 16)

//    static var largeTitle: Font { Font.custom(appFontBold, size: 24) }
//    static var title: Font { Font.custom(appFontBold, size: 20) }
//    static var body: Font { Font.custom(appFontRegular, size: 16) }
}

extension UIFont {
    static let largeNavigationTitle = UIFont(name: appFontBold, size: 24)
    static let navigationTitle = UIFont(name: appFontBold, size: 20)
}
