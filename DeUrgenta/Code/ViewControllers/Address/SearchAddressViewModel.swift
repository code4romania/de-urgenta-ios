//
//  SearchAddressViewModel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import Promises

class SearchAddressViewModel: NSObject {
    let addressKind: SafepointAddress.Kind
    
    var searchResults: [MapManager.MapLocation] = []
    
    var selectedLocation: MapManager.MapLocation?
    var userAddress: String { selectedLocation?.address ?? "" }
    
    // TODO: reverse geocode the location
    var addressAtLocation: String?
    
    var canSave: Bool { selectedLocation != nil && !userAddress.isEmpty }
    
    init(addressKind: SafepointAddress.Kind = .home) {
        self.addressKind = addressKind
        super.init()
    }
    
    func search(query: String) -> Promise<()> {
        guard !query.isEmpty else {
            searchResults = []
            return .init(())
        }
        
        let promise = Promise<()>.pending()
        MapManager.shared.geocode(query)
            .then { [weak self] locations -> Void in
                self?.searchResults = locations
                promise.fulfill(())
            }
            .catch { promise.reject($0) }
        return promise
    }
}
