//
//  MapViewModel.swift
//  mapTesting
//
//  Created by Mauricio Chirino on 31/10/20.
//

import CoreLocation
import MauriUtils

final class MapViewModel: NSObject {
    private var trackingHandler: Trackable

    /// Provides mock values for map's camera in order to center itself
    var cameraPosition: MapCamera {
        MapCamera(latitude: -34.8, longitude: -56.1, zoom: 10)
    }

    init(trackingHandler: Trackable = TrackingHandler()) {
        self.trackingHandler = trackingHandler
    }

    func track(title: String?, at coordinates: CLLocationCoordinate2D) {
        trackingHandler.track(title: title, at: coordinates)
    }

    func printTrackerInfo() {
        trackingHandler.showLogs()
    }

    /// Load a marker array in memory from a JSON file within the project's main bundle
    /// - Returns: Decoded `[MarkerInfo]`
    func loadMarkers() -> [MarkerInfoDTO] {
        guard let rawData = FileHelper.read(from: "Markers") else {
            return []
        }

        do {
            let markers:[MarkerInfoDTO] = try JSONDecodable.map(input: rawData)
            return markers
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}
