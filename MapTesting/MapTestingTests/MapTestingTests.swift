//
//  MapTestingTests.swift
//  MapTestingTests
//
//  Created by Mauricio Chirino on 31/10/20.
//

import XCTest
import GoogleMaps
@testable import MapTesting

final class MapTestingTests: XCTestCase {
    func testTappingInteractionWithMarkers() {
        // Given
        let spyTracker = EventTracker()
        let dummyModel = MapViewModel(tracker: spyTracker)
        let mockMap = MapViewController(viewModel: dummyModel)

        // When
        _ = mockMap.view
//        _ = mockMap.mapView(GMSMapView, didTap: GMSMarker)

        // Then
        XCTAssertFalse(spyTracker.isEmpty)
    }
}
