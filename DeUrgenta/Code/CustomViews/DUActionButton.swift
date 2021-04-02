//
//  DUActionButton.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import SnapKit

@IBDesignable
class DUActionButton: DUButton {
    enum Style: String {
        case main
        case inversed
        case transparentLightContent
        case transparentDarkContent

        var backgroundColor: UIColor {
            switch self {
            case .main: return .mainActionButtonBackground
            case .inversed: return .mainActionButtonForeground
            case .transparentLightContent, .transparentDarkContent:
                return .clear
            }
        }

        var foregroundColor: UIColor {
            switch self {
            case .main: return .mainActionButtonForeground
            case .inversed: return .mainActionButtonBackground
            case .transparentDarkContent: return .mainAccent
            case .transparentLightContent: return .white
            }
        }
    }
    
    @IBInspectable
    var style: String = "" {
        didSet {
            innerStyle = Style(rawValue: style) ?? .main
            configureColors()
        }
    }
    
    var innerStyle: Style = .main
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        configure()
    }
    
    private func configure() {
        let font = UIFont(
            name: AppFontFamily.main.fullName(withStyle: .bold),
            size: .buttonFontSize
        )
        updateAppearanceWithFont(font)
        
        configureColors()
        layer.cornerRadius = .buttonCornerRadius
        layer.masksToBounds = true
    }
    
    private func configureColors() {
        setBackgroundImage(innerStyle.backgroundColor.asImage, for: .normal)
        setTitleColor(innerStyle.foregroundColor, for: .normal)
        setTitleColor(innerStyle.foregroundColor, for: .highlighted)
    }
    
}

