//
//  FilledNavbarModifier.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 28.08.2021.
//

import SwiftUI

struct FilledNavbarModifier: ViewModifier {
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        let fgColor = UIColor.homeForeground
        let bgColor = UIColor.homeBackground
        navBarAppearance.titleTextAttributes = [.foregroundColor: fgColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: fgColor]
        navBarAppearance.backgroundColor = bgColor
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = fgColor
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func filledNavigationAppearance() -> some View {
        self.modifier(FilledNavbarModifier())
    }
}
