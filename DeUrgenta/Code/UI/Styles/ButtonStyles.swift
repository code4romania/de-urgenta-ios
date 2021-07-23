//
//  ButtonStyles.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import Foundation
import SwiftUI

struct LargeButton: ButtonStyle {
    let bgColor: Color
    let fgColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(13)
            .foregroundColor(configuration.isPressed ? fgColor.opacity(0.75) : fgColor)
            .background(configuration.isPressed ? bgColor.opacity(0.75) : bgColor)
            .font(.largeButton)
            .cornerRadius(6)
    }
}

struct SmallButton: ButtonStyle {
    let bgColor: Color
    let fgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 9, leading: 17, bottom: 9, trailing: 17))
            .foregroundColor(fgColor)
            .background(bgColor)
            .font(.smallButton)
            .cornerRadius(6)
    }
}

