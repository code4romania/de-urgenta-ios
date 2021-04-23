//
//  MapManager.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import NMAKit
import Promises
import CoreLocation

class MapManager: NSObject {
    static let shared = MapManager()
    
    enum ErrorType: Error {
        case authorizationDenied
        case locationNotFound
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    struct MapLocation {
        var address: String
        var location: CLLocationCoordinate2D
    }
    
    private var currentGeocodeRequest: NMAGeocodeRequest?
    private var currentReverseGeocodeRequest: NMAReverseGeocodeRequest?
    
    static let defaultGeoCenter = CLLocationCoordinate2D(
        latitude: Double(Config.shared.configValue(of: .mapCenterLatitude)) ?? 0,
        longitude: Double(Config.shared.configValue(of: .mapCenterLongitude)) ?? 0
    )
    
    private static let defaultGeoRadius = 2_000
    
    var isLocationEnabled: Bool {
        CLLocationManager.locationServicesEnabled()
    }
    
    var isLocationAccessGranted: Bool {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus == .authorizedWhenInUse
                || locationManager.authorizationStatus == .authorizedAlways
        } else {
            return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
            || CLLocationManager.authorizationStatus() == .authorizedAlways
        }
    }
    
    var isLocationAccessDenied: Bool {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus == .denied
        } else {
            return CLLocationManager.authorizationStatus() == .denied
        }
    }
    
    private var locationPermissionPromise: Promise<()>?
    private var locationRequestPromise: Promise<CLLocationCoordinate2D>?
    
    private override init() {
        super.init()
    }
    
    func configure() {
        let appId = Config.shared.configValue(of: .hereMapAppId)
        let appCode = Config.shared.configValue(of: .hereMapAppCode)
        let licenseKey = Config.shared.configValue(of: .hereMapLicenseKey)
        NMAApplicationContext.setAppId(appId, appCode: appCode, licenseKey: licenseKey)
        LogDebug("Configured Map SDK")
    }
    
    func geocode(_ query: String,
                 center: CLLocationCoordinate2D = MapManager.defaultGeoCenter,
                 radius: Int = MapManager.defaultGeoRadius) -> Promise<[MapLocation]>  {
        if let currentRequest = currentGeocodeRequest {
            // cancel any ongoing requests
            currentRequest.cancel()
        }
        
        let searchCenter = NMAGeoCoordinates(latitude: center.latitude, longitude: center.longitude)
        let request = NMAGeocoder.sharedInstance()
            .createGeocodeRequest(
                query: query, searchRadius: radius,
                searchCenter: searchCenter
            )
        self.currentGeocodeRequest = request
        let promise = Promise<[MapLocation]>.pending()
        request.start { [weak self] (req, data, error) in
            if let error = error {
                promise.reject(error)
                self?.currentGeocodeRequest = nil
            } else {
                guard let list = data as? [NMAGeocodeResult] else {
                    promise.fulfill([])
                    self?.currentGeocodeRequest = nil
                    return
                }
                
                promise.fulfill(
                    list.compactMap { result in
                        guard let location = result.location,
                              let position = location.position else { return nil }
                        return MapLocation(
                            address: location.address?.formattedAddress ?? "",
                            location: CLLocationCoordinate2D(
                                latitude: position.latitude, longitude: position.longitude)
                        )
                    }
                )
                self?.currentGeocodeRequest = nil
            }
        }
        return promise
    }
    
    func reverseGeocode(_ coordinate: CLLocationCoordinate2D) -> Promise<MapLocation> {
        let promise = Promise<MapLocation>.pending()
        
        if let currentRequest = currentReverseGeocodeRequest {
            // cancel any ongoing requests
            currentRequest.cancel()
        }
        
        let c = NMAGeoCoordinates()
        c.latitude = coordinate.latitude
        c.longitude = coordinate.longitude
        currentReverseGeocodeRequest = NMAGeocoder.sharedInstance()
            .createReverseGeocodeRequest(coordinates: c)
        currentReverseGeocodeRequest?.start { [weak self] (req, data, error) in
                if let error = error {
                    promise.reject(error)
                    self?.currentReverseGeocodeRequest = nil
                } else {
                    guard let list = data as? [NMAReverseGeocodeResult],
                          let first = list.first,
                          let location = first.location,
                          let position = location.position else {
                        promise.reject(ErrorType.locationNotFound)
                        self?.currentReverseGeocodeRequest = nil
                        return
                    }

                    let mapLocation = MapLocation(
                        address: location.address?.formattedAddress ?? "",
                        location: CLLocationCoordinate2D(
                            latitude: position.latitude, longitude: position.longitude)
                    )
                    
                    promise.fulfill(mapLocation)
                    self?.currentReverseGeocodeRequest = nil
                }
            }
        return promise
    }
    
    func getPermissions() -> Promise<()> {
        let promise = Promise<()>.pending()
        if isLocationAccessGranted {
            promise.fulfill(())
        } else {
            self.locationPermissionPromise = promise
            locationManager.requestWhenInUseAuthorization()
        }
        return promise
    }
    
    func askForLocation() -> Promise<CLLocationCoordinate2D> {
        let promise = Promise<CLLocationCoordinate2D>.pending()
        locationRequestPromise = promise
        locationManager.requestLocation()
        return promise
    }
    
}

extension MapManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.authorizationStatus() == .denied {
            locationPermissionPromise?.reject(ErrorType.authorizationDenied)
        } else {
            locationPermissionPromise?.fulfill(())
        }
        locationPermissionPromise = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            locationRequestPromise?.fulfill(coordinate)
        } else {
            locationRequestPromise?.reject(ErrorType.locationNotFound)
        }
        locationRequestPromise = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationRequestPromise?.reject(error)
        locationRequestPromise = nil
    }
}
