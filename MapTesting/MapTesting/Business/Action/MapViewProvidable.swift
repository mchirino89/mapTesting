//
//  MapViewProvidable.swift
//  MapTesting
//
//  Created by Mauricio Chirino on 01/11/20.
//

import GoogleMaps

protocol MapViewProvidable {
    /// Wrapper for Google maps (_GMSMapView_ inherits from `UIView`)
    var mapView: UIView { get }

    /// Assigns the delegate listener
    var delegate: MapProviderDelegate? { get set }

    /// Centers the camera point of view
    /// - Parameter cameraPosition: coordinates and zoom level to set the camera in
    func animate(to cameraPosition: MapCamera)

    /// Creates and adds a pin marker to the map view
    /// - Parameter markerInfo: information needed for map's proper rendering
    func createMarker(basedOn markerInfo: MarkerInfoDTO)
}

extension MapViewProvidable {
    /// Safe wrapper to access Google map's properties
    var mapWrapper: GMSMapView? {
        mapView as? GMSMapView
    }
}
