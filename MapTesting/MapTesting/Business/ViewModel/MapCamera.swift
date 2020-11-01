//
//  MapCamera.swift
//  MapTesting
//
//  Created by Mauricio Chirino on 01/11/20.
//

struct MapCamera {
    let zoomLevel: Float
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double, zoom: Float) {
        self.zoomLevel = zoom
        self.latitude = latitude
        self.longitude = longitude
    }
}
