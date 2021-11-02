//
//  AddressEntryViewModel.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 28.08.2021.
//

import Foundation
import Promises
import CoreLocation
import Combine
import NMAKit

extension AddressEntryView {
    class ViewModel: NSObject, ObservableObject {
        var searchType: LocationSearchType
        
        @Published var currentAddressText: String = ""
        
        @Published var searchResults: [MapManager.MapLocation] = [
//            MapManager.MapLocation(address: "Str. Neculau", location: CLLocationCoordinate2D(latitude: 45, longitude: 45)),
//            MapManager.MapLocation(address: "Str. Tudor Neculai", location: CLLocationCoordinate2D(latitude: 45, longitude: 45))
        ]
        
        @Published var mapState: GlobalMapStateModel = GlobalMapStateModel()
        
        var selectedLocation: MapManager.MapLocation? {
            didSet {
                canSave = selectedLocation != nil && !userAddress.isEmpty
                if let location = selectedLocation?.location {
                    let geoCenter = NMAGeoCoordinates(
                        latitude: location.latitude,
                        longitude: location.longitude
                    )
                    mapState.geoCenter = geoCenter
                    mapState.showsPin = true
                } else {
                    mapState.showsPin = false
                }
            }
        }
        var userAddress: String { selectedLocation?.address ?? "" }
        
        // TODO: reverse geocode the location
        var addressAtLocation: String?
        
        @Published var isEditingSearch = false
        @Published var isLoading = false
        @Published var isLocating = false
        @Published var canSave = false
        
        @Published var currentErrorMessage: String? {
            didSet {
                isError = currentErrorMessage != nil && !currentErrorMessage!.isEmpty
            }
        }
        @Published var isError: Bool = false
        
        var canLocate: Bool {
            !MapManager.shared.isLocationAccessDenied
        }
        
        var screenTitle: String {
            calculateScreenTitle()
        }
        
        private var subscription: Set<AnyCancellable> = []
        
        init(searchType: LocationSearchType = .address(kind: .home)) {
            self.searchType = searchType

            super.init()
            
            $currentAddressText
                .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
                .removeDuplicates()
                .compactMap { $0 }
                .sink { _ in
                    
                } receiveValue: { [self] query in
                    search(query: query)
                        .catch { [weak self] error in
                            self?.currentErrorMessage = "Nu am putut efectua căutarea: \(error.localizedDescription)"
                        }
                }
                .store(in: &subscription)
            
            let geoCenterLocation = MapManager.defaultGeoCenter
            let geoCenter = NMAGeoCoordinates(
                latitude: geoCenterLocation.latitude,
                longitude: geoCenterLocation.longitude
            )
            mapState.geoCenter = geoCenter
            mapState.zoom = 20
        }
        
        func search(query: String) -> Promise<()> {
            currentErrorMessage = nil
            
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
        
        func locationWasPickedFromList(_ location: MapManager.MapLocation) {
            selectedLocation = location
        }
        
        func detectUserLocation() {
            currentErrorMessage = nil
            
            guard canLocate else {
                currentErrorMessage = "Ai dezactivat permisiunea pentru localizare."
                return
            }
            
            isLocating = true
            AddressLocalisationAdapter.shared.detectUserLocation()
                .then { [weak self] location in
                    guard let self = self else { return }
                    self.selectedLocation = location
                    self.isLocating = false
                    self.currentAddressText = self.userAddress
                }
                .catch { [weak self] error in
                    self?.isLocating = false
                    self?.currentErrorMessage = error.localizedDescription
                }
        }
        
    }
}

class AddressLocalisationAdapter: NSObject {
    static let shared = AddressLocalisationAdapter()
    
    enum ErrorType: Error, LocalizedError {
        case didNotStart
    }
    
    private var promise: Promise<MapManager.MapLocation>?
    
    override init() {
        super.init()
//        NMAPositioningManager.sharedInstance().dataSource = NMAHEREPositionSource()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLocationUpdate),
            name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
            object: NMAPositioningManager.sharedInstance())
        
    }
    
    func detectUserLocation() -> Promise<MapManager.MapLocation> {
        promise = .pending()
        
        let didStart = NMAPositioningManager.sharedInstance().startPositioning()
        LogDebug("did start positioning? \(didStart)")
        
        if !didStart {
            promise?.reject(ErrorType.didNotStart)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.handleLocationUpdate()
        }
        
        return promise!
    }
    
    @objc
    private func handleLocationUpdate() {
        let position = NMAPositioningManager.sharedInstance().currentPosition
        guard let coordinates = position?.coordinates else { return }
        let c2d = CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
        LogDebug("found coordinate: \(c2d)")
        
//        NMAPositioningManager.sharedInstance().stopPositioning()

        MapManager.shared.reverseGeocode(c2d)
            .then { [weak self] location in
                self?.promise?.fulfill(location)
                LogDebug("Reversed geocode of location: \(location)")
            }
            .catch { [weak self] error in
                LogError("Could not reverse geocode: \(error)")
                self?.promise?.reject(error)
            }
    }
}
