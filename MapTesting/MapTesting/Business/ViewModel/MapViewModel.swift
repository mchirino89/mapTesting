//
//  MapViewModel.swift
//  mapTesting
//
//  Created by Mauricio Chirino on 31/10/20.
//

import CoreLocation
import MauriUtils

final class MapViewModel: NSObject {
    private var tracker: [String: Tracking]

    init(tracker: [String: Tracking] = [:]) {
        self.tracker = tracker
        super.init()
    }

    /// Keeps track of marker's tap in a dictionary
    /// - Parameters:
    ///   - title: marker's title
    ///   - coordinates: coordinate where the marker is, which will be used as dictionary's key
    func track(title: String?, at coordinates: CLLocationCoordinate2D) {
        if tracker["\(coordinates)"] == nil {
            tracker["\(coordinates)"] = Tracking(tappedMarker: title ?? "N/A", numberOfTaps: 1)
        } else {
            tracker["\(coordinates)"]?.numberOfTaps += 1
        }
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
