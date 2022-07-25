import CoreLocation
import Foundation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus

    @Published var location: CLLocationCoordinate2D?
    @Published var currentCity: String?

    let locations = ["Bucuresti", "Sibiu", "Brasov"]

    private let locationManager: CLLocationManager

    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus

        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            currentCity = locations.first
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate

        lookUpCurrentLocation { response in
            self.currentCity = response?.locality
        }
    }

    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void) {
        if let lastLocation = locationManager.location {
            let geocoder = CLGeocoder()

            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { placemarks, error in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                } else {
                                                    completionHandler(nil)
                                                }
                                            })
        } else {
            completionHandler(nil)
        }
    }
}
