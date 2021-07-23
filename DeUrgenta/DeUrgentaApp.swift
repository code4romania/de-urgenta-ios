//
//  DeUrgentaApp.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import SwiftUI

@main
struct DeUrgentaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .onAppear(perform: {
                AppManager.shared.setup()
                setupAppearance()
            })
        }
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.navigationTitle!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont.largeNavigationTitle!
        ]
        
    }
}
