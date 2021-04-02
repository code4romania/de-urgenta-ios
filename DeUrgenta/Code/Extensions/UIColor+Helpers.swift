//
//  UIColor+Helpers.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        var hexInt: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)

        self.init(hexCode: hexInt)
    }
    
    convenience init(hexCode: UInt32) {
        var alpha = hexCode >> 24 & 0xFF
        let red   = hexCode >> 16 & 0xFF
        let green = hexCode >> 8 & 0xFF
        let blue  = hexCode >> 0 & 0xFF
        if alpha == 0 {
            alpha = 0xFF
        }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha:CGFloat(alpha) / 255.0)
    }
}
