//
//  AddressModels.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 03.04.2021.
//

import Foundation
import UIKit
import CoreLocation

struct LocationCoordinates: Codable {
    var latitude: Double
    var longitude: Double
}

struct DULocation: Codable {
    var address: String
    var coordinates: LocationCoordinates
}

struct DUAddress: Codable {
    enum Kind: String, Codable {
        case home
        case work
        case school
        case gym
        case other
    }
    
    var kind: Kind
    var location: DULocation
}

struct DUMeetingPoint: Codable {
    var location: DULocation
}

enum LocationSearchType {
    case address(kind: DUAddress.Kind)
    case meetingPoint(isPrimary: Bool)
}
