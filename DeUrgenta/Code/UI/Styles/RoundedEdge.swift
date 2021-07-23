//
//  RoundedEdge.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import Foundation
import SwiftUI

struct RoundedEdge: ViewModifier {
    let width: CGFloat
    let color: Color
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content.cornerRadius(cornerRadius - width)
            .padding(width)
            .background(color)
            .cornerRadius(cornerRadius)
    }
}
