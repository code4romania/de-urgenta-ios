//
//  DashboardViewModel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.07.2021.
//

import Foundation

extension DashboardView {
    class ViewModel: ObservableObject {
        @Published var selectedOption: Item?
        
        var areAllOptionsAvailable: Bool { return false }
        
        struct Item: Identifiable {
            var id: IdType
            var name: String
            var iconName: String
            
            enum IdType: String {
                case addresses
                case group
                case backpack
                case firstAid
            }
        }
        
        static let allItems: [Item] = [
            Item(id: .addresses, name: "Configurează adresele", iconName: "config.map-icon"),
            Item(id: .group, name: "Creează-ți grupul", iconName: "config.group-icon"),
            Item(id: .backpack, name: "Fă-ți rucsacul de urgență", iconName: "config.bag-icon"),
            Item(id: .firstAid, name: "Învață să dai primul ajutor", iconName: "config.red-cross-icon")
        ]
        
    }
}
