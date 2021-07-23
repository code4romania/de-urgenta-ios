//
//  AppManager.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 01.04.2021.
//

import UIKit
import FirebaseCore

/// Handles everything related to the overall App setup
class AppManager: NSObject {
    static let shared = AppManager()
    
    static var disableDependencies = false
    
    private var isSetupComplete = false
    
    private override init() {
        super.init()
    }
    
    func setup() {
        guard !Self.disableDependencies && !isSetupComplete else { return }
        
        // Make sure you created the Firebase project and downloaded the GoogleService-Info.plist
        // file into the project folder, or this will fail
        DispatchQueue.main.async {
            FirebaseApp.configure()
            
            // Make sure you created a Here map account and added the details into your LocalConfig.xcconfig
            MapManager.shared.configure()
            
            // Load the core data container
            LocalStorage.shared.createLocalContainer { container in
                LogInfo("Loaded container.")
            }
            
            // Load the remote config
            // TODO: load before UI
            Config.shared.loadRemoteConfig()
                .then { LogDebug("Loaded remote config") }
                .catch { LogError("Error while loading remote config: \($0)") }
            
    //        setupAppearance()
            
            self.isSetupComplete = true
        }
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = .navBackButton
        UINavigationBar.appearance().backIndicatorImage = .navBackButton
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .mainAccent
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
        
        let titleFont = UIFont(name: AppFontFamily.main.fullName(withStyle: .bold), size: 16)!
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: titleFont
        ]
        
    }
}
