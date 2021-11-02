//
//  DeUrgentaApp.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 21.07.2021.
//

import SwiftUI

@main
struct DeUrgentaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainNavigation()
            .onAppear(perform: {
//                AppManager.shared.setup()
                Self.setupAppearance()
            })
        }
    }
    
    static func setupAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.navigationTitle!,
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont.largeNavigationTitle!,
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().barTintColor = UIColor.mainAccent
    }
}
