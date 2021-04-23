//
//  UINavigationBar+Styles.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.04.2021.
//

import UIKit

enum DUNavigationBarStyle {
    case opaqueLightContent
    case translucentDarkContent
}

extension UINavigationBar {
    func setStyle(_ style: DUNavigationBarStyle) {
        switch style {
        case .opaqueLightContent:
            barStyle = .black
            isTranslucent = false
            barTintColor = .mainAccent
            tintColor = .white
            shadowImage = UIImage()
        case .translucentDarkContent:
            barStyle = .default
            isTranslucent = true
            barTintColor = .white
            tintColor = .black
            shadowImage = UIImage()
        }
    }
}

extension UINavigationItem {
    func removeBackTitle() {
        if #available(iOS 14.0, *) {
            backButtonTitle = ""
            backButtonDisplayMode = .minimal
        } else if #available(iOS 11.0, *) {
            backButtonTitle = ""
        } else {
            // Fallback on earlier versions
            backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
