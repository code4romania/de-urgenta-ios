//
//  MainAppEnvironment.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 30.08.2021.
//

import Foundation

class MainAppEnvironment: ObservableObject {
    static let shared = MainAppEnvironment()
    
    enum NavigationRoute {
        case `public`
        case authenticated
    }
    
    @Published var navigationRoute: NavigationRoute = .public
}
