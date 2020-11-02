//
//  Tracking.swift
//  mapTesting
//
//  Created by Mauricio Chirino on 31/10/20.
//

import CoreLocation

typealias EventTracker = [String: Tracking]

protocol Trackable {
    mutating func track(title: String?, at coordinates: CLLocationCoordinate2D)
    func showLogs()
}

struct Tracking {
    let tappedMarker: String
    var numberOfTaps: Int
}

struct TrackingHandler: Trackable {
    private var tracker: EventTracker = [:]

    /// Keeps track of marker's tap in a dictionary
    /// - Parameters:
    ///   - title: marker's title
    ///   - coordinates: coordinate where the marker is, which will be used as dictionary's key
    mutating func track(title: String?, at coordinates: CLLocationCoordinate2D) {
        if tracker["\(coordinates)"] == nil {
            tracker["\(coordinates)"] = Tracking(tappedMarker: title ?? "N/A", numberOfTaps: 1)
        } else {
            tracker["\(coordinates)"]?.numberOfTaps += 1
        }
    }

    func showLogs() {
        print("===============")
        tracker.forEach {
            print("Tapped \($1.numberOfTaps) times on \($1.tappedMarker)")
        }
        print("===============")
    }

}
