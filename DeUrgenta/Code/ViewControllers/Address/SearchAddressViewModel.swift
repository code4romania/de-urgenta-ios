//
//  SearchAddressViewModel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import Promises

class SearchAddressViewModel: NSObject {
    let searchType: LocationSearchType
    
    var searchResults: [MapManager.MapLocation] = []
    
    var selectedLocation: MapManager.MapLocation?
    var userAddress: String { selectedLocation?.address ?? "" }
    
    // TODO: reverse geocode the location
    var addressAtLocation: String?
    
    var canSave: Bool { selectedLocation != nil && !userAddress.isEmpty }
    
    var screenTitle: String {
        calculateScreenTitle()
    }
    
    init(searchType: LocationSearchType = .address(kind: .home)) {
        self.searchType = searchType
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
    
    private func calculateScreenTitle() -> String {
        var title = ""
        switch searchType {
        case .meetingPoint:
            title += "Setează un punct de întâlnire"
        case .address(let kind):
            title += "Adaugă-ți "
            switch kind {
            case .home:
                title += "adresa de domiciliu"
            case .work:
                title += "adresa de serviciu"
            case .school:
                title += "adresa școlii"
            case .gym:
                title += "adresa sălii de sport"
            case .other:
                title = "Adaugă altă adresă"
            }
        }
        return title
    }
}
