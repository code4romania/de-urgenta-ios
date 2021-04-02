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
}
