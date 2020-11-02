//
//  MapViewProviderFake.swift
//  MapTestingTests
//
//  Created by Mauricio Chirino on 01/11/20.
//

import UIKit
@testable import MapTesting

struct MapViewProviderFake: MapViewProvidable {
    var mapView: UIView
    var delegate: MapProviderDelegate?

    init(mapView: UIView = UIView()) {
        self.mapView = mapView
    }

    func animate(to cameraPosition: MapCamera) { }

    func createMarker(basedOn markerInfo: MarkerInfoDTO) { }
}
