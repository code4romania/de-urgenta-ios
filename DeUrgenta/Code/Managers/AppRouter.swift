//
//  AppRouter.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit

class AppRouter: NSObject {
    static let shared = AppRouter()
    
    let mainNavigation = UINavigationController()
    
    private override init() {
        super.init()
    }
    
    func navigateToStart() {
        navigateToAppEntry()
        AccountManager.shared.authenticate()
            .then { _ in self.navigateToDashboard() }
            .catch { _ in self.navigateToUnauthenticated() }
    }
    
    func navigateToAppEntry() {
        let root = AppEntryViewController()
        mainNavigation.setViewControllers([root], animated: false)
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = mainNavigation
    }
    
    func navigateToDashboard() {
        let root = InfoConfigurationViewController()
        mainNavigation.setViewControllers([root], animated: false)
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = mainNavigation
    }
    
    func navigateToUnauthenticated() {
        let root = WelcomeViewController()
        mainNavigation.setViewControllers([root], animated: false)
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = mainNavigation
    }
    
    func push(_ vc: DUViewController, animated: Bool = true, to nav: UINavigationController? = nil) {
        let destination = nav ?? mainNavigation
        destination.pushViewController(vc, animated: animated)
    }
}
