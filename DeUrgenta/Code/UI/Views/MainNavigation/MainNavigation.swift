//
//  MainNavigation.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 30.08.2021.
//

import SwiftUI

struct MainNavigation: View {
    @StateObject var environment = MainAppEnvironment.shared
    
    var body: some View {
        NavigationView {
            switch environment.navigationRoute {
            case .public:
                HomeView()
            case .authenticated:
                DashboardView()
            }
        }
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
