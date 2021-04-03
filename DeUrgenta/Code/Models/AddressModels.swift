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

struct SafepointAddress: Codable {
    enum Kind: String, Codable {
        case home
        case work
        case school
        case gym
        case other
    }
    
    var address: String
    var coordinates: LocationCoordinates
    var kind: Kind
}
