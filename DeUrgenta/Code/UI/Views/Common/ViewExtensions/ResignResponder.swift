//
//  ResignResponder.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 01.11.2021.
//

import UIKit
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
