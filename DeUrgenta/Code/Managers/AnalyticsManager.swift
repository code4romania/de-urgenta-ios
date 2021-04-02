//
//  AnalyticsManager.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import FirebaseAnalytics

/// Use this class to log analytics events
class AnalyticsManager: NSObject {
    static let shared = AnalyticsManager()
    
    private override init() {
        super.init()
    }
    
    func log(_ event: DUAnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
}

/// All the logged events are in this enum
enum DUAnalyticsEvent {
    case screenVisited(name: String)
    
    var name: String {
        switch self {
        case .screenVisited: return "screenVisited"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .screenVisited(let name): return ["name": name]
        }
    }
}
