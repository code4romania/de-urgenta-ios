import CoreLocation
import Foundation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus

    var location: CLLocationCoordinate2D?
    var currentCity: String?
    
    static var uniqueKey: String {
        UUID().uuidString
    }

    let locations: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Bucuresti"),
        DropdownOption(key: uniqueKey, value: "Sibiu"),
        DropdownOption(key: uniqueKey, value: "Brasov"),
    ]

    let courses: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "First Aid"),
        DropdownOption(key: uniqueKey, value: "Qualified first aid"),
        DropdownOption(key: uniqueKey, value: "Disaster preparedness"),
    ]

    var currentCourse: String

    private let locationManager: CLLocationManager

    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        currentCourse = courses.first!.value

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
            currentCity = locations.first!.value
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
