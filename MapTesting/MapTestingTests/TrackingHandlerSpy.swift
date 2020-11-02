//
//  TrackingHandlerSpy.swift
//  MapTestingTests
//
//  Created by Mauricio Chirino on 02/11/20.
//

import CoreLocation
@testable import MapTesting

final class TrackingHandlerSpy: Trackable {
    var invokedTrack = false
    var invokedTrackCount = 0
    var invokedTrackParameters: (title: String?, coordinates: CLLocationCoordinate2D)?
    var invokedTrackParametersList = [(title: String?, coordinates: CLLocationCoordinate2D)]()

    func track(title: String?, at coordinates: CLLocationCoordinate2D) {
        invokedTrack = true
        invokedTrackCount += 1
        invokedTrackParameters = (title, coordinates)
        invokedTrackParametersList.append((title, coordinates))
    }

    var invokedShowLogs = false
    var invokedShowLogsCount = 0

    func showLogs() {
        invokedShowLogs = true
        invokedShowLogsCount += 1
    }
}
