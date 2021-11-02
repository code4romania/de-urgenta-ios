//
//  UIImage+Presets.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import SwiftUI

/// Add all the images to use here, do not hard code them directly in the classes
extension UIImage {
    static let navBackButton = localImage(named: "but-back-dark")
    static let whiteLogo = localImage(named: "white-logo")
    static let mapPinIcon = localImage(named: "icon-map-pin")
    static let successMessageIcon = localImage(named: "green-checkmark")
    static let largeSpinner = localImage(named: "spinner-large")

    private static func localImage(named: String) -> UIImage? {
        UIImage(named: named, in: Bundle(for: AppDelegate.self), compatibleWith: nil)
    }
    
    static func addressIcon(ofKind kind: DUAddress.Kind) -> UIImage? {
        localImage(named: "icon-address-\(kind.rawValue)")
    }
}
