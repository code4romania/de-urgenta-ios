//
//  DUMapView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 28.08.2021.
//

import SwiftUI
import UIKit
import NMAKit

// Wrapper for NMAMapView
struct HEREMapsView: UIViewRepresentable {

    // Intended to notify of map state changes to external SwiftUI
    @EnvironmentObject var stateModel: GlobalMapStateModel

    // Intended to listen to external SwiftUI events and update NMAMapView scheme
    @Binding var mapScheme: String

    // Main map instance
    private let mapView = NMAMapView.init(frame: .zero)
    
    func makeUIView(context: Self.Context) -> NMAMapView {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        // Use coordinator approach to pass UIKit events to SwiftUI
        mapView.gestureDelegate = context.coordinator

        // Setup rest of mapView settins
        mapView.copyrightLogoPosition = .topRight
        mapView.zoomLevel = stateModel.zoom
        mapView.tilt = stateModel.tilt
        if let center = stateModel.geoCenter {
            mapView.set(geoCenter: center, animation: .none)
            if stateModel.showsPin,
               let pinMarker = stateModel.mapPinMarker {
                mapView.add(mapObject: pinMarker)
            }
        }
        
        if !stateModel.showsPin || stateModel.geoCenter == nil {
            mapView.removeAllMapObjects()
        }

        return mapView
    }

    func updateUIView(_ mapView: NMAMapView, context: Context) {
        // Update map scheme which might get changed by Picker selection
        mapView.mapScheme = mapScheme
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(stateModel: _stateModel)
    }

    class Coordinator: NSObject, NMAMapGestureDelegate {
        @EnvironmentObject private var stateModel: GlobalMapStateModel

        init(stateModel: EnvironmentObject<GlobalMapStateModel>) {
            self._stateModel = stateModel
        }

        // MARK: NMAMapGestureDelegate
        func mapView(_ mapView: NMAMapView,
                     didReceivePinch pinch: Float,
                     at location: CGPoint) {

            // Let the map handle this pinch
            mapView.defaultGestureHandler?.mapView?(mapView, didReceivePinch: pinch, at: location)

            // Notify of zoom change to shared state
            self.stateModel.zoom = mapView.zoomLevel
        }

        func mapView(_ mapView: NMAMapView,
                     didReceiveTwoFingerPan translation: CGPoint,
                     at location: CGPoint) {

            // Let the map handle this pan
            mapView.defaultGestureHandler?.mapView?(mapView,
                                                    didReceiveTwoFingerPan: translation,
                                                    at: location)
            // Notify of tilt change to shared state
            stateModel.tilt = mapView.tilt
        }
    }
}

#if DEBUG
struct HEREMapsView_Previews: PreviewProvider {
    @State private static var name = NMAMapSchemeNormalNight

    static var previews: some View {
        HEREMapsView(mapScheme: $name).environmentObject(GlobalMapStateModel())
    }
}
#endif

class GlobalMapStateModel : ObservableObject {
    @Published var zoom: Float = 20
    @Published var tilt: Float = 0

    @Published var geoCenter: NMAGeoCoordinates?
    @Published var showsPin = false {
        didSet {
            if showsPin,
               let center = geoCenter {
                mapPinMarker = NMAMapMarker(geoCoordinates: center, image: UIImage.mapPinIcon!)
                mapPinMarker?.anchorOffset = CGPoint(x: 0, y: -21)
            }
        }
    }
    
    var mapPinMarker: NMAMapMarker? = nil
    //Add another settigns for observation here
}
