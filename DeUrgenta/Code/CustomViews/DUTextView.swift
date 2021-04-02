//
//  DUTextView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit

/// Use this instead of the UIKit parent, it allows font generalization
@IBDesignable
class DUTextView: UITextView, StandardTextElement {
    
    @IBInspectable var fontFamily: String?
    @IBInspectable var fontStyle: String?
    
    func updateAppearanceWithFont(_ font: UIFont?) {
        if let font = font {
            self.font = font
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAppearanceWithFont(AppFont.font(withFamilyStr: fontFamily,
                                              styleStr: fontStyle,
                                              size: font?.pointSize ?? 10))
    }
}
