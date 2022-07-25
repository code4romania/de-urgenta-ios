import SwiftUI

struct SelectCourseAndCityView: View {
    @ObservedObject var locationManager: LocationViewModel

    var body: some View {
        Text(locationManager.currentCity ?? "")
    }
}
