//
//  StandardNavbarModifier.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 29.08.2021.
//

import SwiftUI

struct StandardNavbarModifier: ViewModifier {
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        let fgColor = UIColor.mainForeground
        let bgColor = UIColor.clear
        let titleFont = UIFont(name: AppFontFamily.main.fullName(withStyle: .bold), size: 16)!
        let largeTitleFont = UIFont(name: AppFontFamily.main.fullName(withStyle: .bold), size: 24)!
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: fgColor,
            .font: titleFont
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: fgColor,
            .font: largeTitleFont
        ]
        navBarAppearance.backgroundColor = bgColor
        navBarAppearance.configureWithTransparentBackground()
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
    func standardNavigationAppearance() -> some View {
        self.modifier(StandardNavbarModifier())
    }
}
