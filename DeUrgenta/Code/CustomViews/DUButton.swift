//
//  DUButton.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit

/// Use this instead of the UIKit parent, it allows font generalization
@IBDesignable
class DUButton: UIButton, StandardTextElement {
    
    @IBInspectable var fontFamily: String?
    @IBInspectable var fontStyle: String?
    
    func updateAppearanceWithFont(_ font: UIFont?) {
        if let font = font {
            self.titleLabel?.font = font
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateAppearanceWithFont(AppFont.font(withFamilyStr: fontFamily,
                                              styleStr: fontStyle,
                                              size: titleLabel?.font?.pointSize ?? 10))
    }
}
