//
//  AppManager.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 01.04.2021.
//

import UIKit
import FirebaseCore

class AppManager: NSObject {
    static let shared = AppManager()
    
    private var isSetupComplete = false
    
    private override init() {
        super.init()
    }
    
    func setup() {
        guard !isSetupComplete else { return }
        
        // Make sure you created the Firebase project and downloaded the GoogleService-Info.plist
        // file into the project folder, or this will fail
        FirebaseApp.configure()
        
        // Load the remote config
        Config.shared.loadRemoteConfig()
            .then { print("loaded remote config") }
            .catch { print("error while loading remote config: \($0)") }
        
        isSetupComplete = true
    }
}
