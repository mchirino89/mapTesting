//
//  MapViewProvider.swift
//  MapTesting
//
//  Created by Mauricio Chirino on 01/11/20.
//

import GoogleMaps

final class MapViewProvider: NSObject, MapViewProvidable {
    lazy var mapView: UIView = {
        GMSMapView()
    }()

    /// Propagates to its listeners the notifications received from Gmap SDK
    weak var delegate: MapProviderDelegate? {
        didSet {
            mapWrapper?.delegate = self
        }
    }

    func animate(to cameraPosition: MapCamera) {
        mapWrapper?.animate(to: GMSCameraPosition(latitude: cameraPosition.latitude,
                                                  longitude: cameraPosition.longitude,
                                                  zoom: cameraPosition.zoomLevel))
    }

    func createMarker(basedOn markerInfo: MarkerInfoDTO) {
        let marker = GMSMarker()
        marker.title = markerInfo.title
        marker.snippet = markerInfo.snippet
        marker.position = CLLocationCoordinate2D(latitude: markerInfo.latitude,
                                                 longitude: markerInfo.longitude)
        marker.map = mapWrapper
    }
}

// MARK: - Delegate propagation
extension MapViewProvider: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        delegate?.tapMarker(titled: marker.title, at: marker.position)

        return false
    }
}
