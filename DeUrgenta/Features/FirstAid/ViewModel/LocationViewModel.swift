import CoreLocation
import Foundation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus

    var location: CLLocationCoordinate2D?
    @Published var currentCity: String = ""

    static var uniqueKey: String {
        UUID().uuidString
    }

    var locations: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Bucuresti"),
        DropdownOption(key: uniqueKey, value: "Brasov"),
        DropdownOption(key: uniqueKey, value: "Cluj"),
    ]

    let courses: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Prim ajutor"),
        DropdownOption(key: uniqueKey, value: "Prim ajutor calificat"),
        DropdownOption(key: uniqueKey, value: "Pregătire în caz de dezastre"),
    ]

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
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate

        lookUpCurrentLocation { response in
            self.currentCity = response?.locality ?? ""
        }

        if currentCity != "", !self.locations.contains(where: { $0.value == currentCity }) {
            self.locations.append(DropdownOption(key: UUID().uuidString, value: currentCity))
        }

        locationManager.stopUpdatingLocation()
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization _: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }

    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void) {
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
