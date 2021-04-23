//
//  UIColor+Presets.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit

/// We'll be using this for all common colors, because we can't use color assets (minimum deployment version too low)
extension UIColor {
    static let mainAccent = UIColor(hexCode: 0xEC1A3A)
    static let mainActionButtonBackground = mainAccent
    static let mainActionButtonForeground = white
    static let appGreen = UIColor(hexCode: 0x059669)
    static let inputBorder = UIColor(hexCode: 0xD1D5DB)

    static let successMessageForeground = appGreen
    static let errorMessageForeground = red
    
    static let lighterText = UIColor(hexCode: 0x374151)
    static let regularText = UIColor(hexCode: 0x1F2937)
    
    static let fullScreenLoadingOverlay = UIColor(hexCode: 0xCDFFFFFF)
    
}
