//
//  MapTestingTests.swift
//  MapTestingTests
//
//  Created by Mauricio Chirino on 31/10/20.
//

import XCTest
import CoreLocation
@testable import MapTesting

final class MapTestingTests: XCTestCase {
    func testTappingInteractionWithMarkers() {
        // Given
        let spyTracker = TrackingHandlerSpy()
        let dummyModel = MapViewModel(trackingHandler: spyTracker)
        let mockMapController = MapViewController(viewModel: dummyModel,
                                                  mapContainer: MapViewProviderFake())
        // When
        mockMapController.viewDidLoad()
        mockMapController.tapMarker(titled: "lorem ipsum",
                                    at: CLLocationCoordinate2D(latitude: 34, longitude: -56))
        // Then
        XCTAssertEqual(spyTracker.invokedTrackCount, 1)
    }
}
