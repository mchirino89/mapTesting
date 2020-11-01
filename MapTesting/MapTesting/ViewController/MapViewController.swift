//
//  MapViewController.swift
//  mapTesting
//
//  Created by Mauricio Chirino on 26/10/20.
//

import GoogleMaps
import MauriUtils

final class MapViewController: UIViewController {
    private lazy var mapView: GMSMapView = {
        let map = GMSMapView(frame: view.frame, camera: GMSCameraPosition(latitude: -34.8,
                                                                          longitude: -56.1,
                                                                          zoom: 10))
        map.delegate = self
        return map
    }()

    private var tracker: [String: Tracking] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        addMarkers()
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if tracker["\(marker.position)"] == nil {
            tracker["\(marker.position)"] = Tracking(tappedMarker: marker.title ?? "N/A", numberOfTaps: 1)
        } else {
            tracker["\(marker.position)"]?.numberOfTaps += 1
        }

        return false
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        tracker.forEach {
            print("Key: \($0) - Value: \($1.numberOfTaps) / \($1.tappedMarker)")
        }
    }
}

private extension MapViewController {
    func setupMap() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }

    func addMarkers() {
        let markers = loadMarkers()
        markers.forEach {
            self.createMarker(basedOn: $0)
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

    func createMarker(basedOn markerInfo: MarkerInfoDTO) {
        let marker = GMSMarker()
        marker.title = markerInfo.title
        marker.snippet = markerInfo.snippet
        marker.position = CLLocationCoordinate2D(latitude: markerInfo.latitude, longitude: markerInfo.longitude)
        marker.map = mapView
    }
}
