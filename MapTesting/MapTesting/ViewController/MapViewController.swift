//
//  MapViewController.swift
//  mapTesting
//
//  Created by Mauricio Chirino on 26/10/20.
//

import GoogleMaps

final class MapViewController: UIViewController {
    private lazy var mapView: GMSMapView = {
        let map = GMSMapView(frame: view.frame, camera: GMSCameraPosition(latitude: -34.8,
                                                                          longitude: -56.1,
                                                                          zoom: 10))
        map.delegate = self
        return map
    }()

    private let viewModel: MapViewModel

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        addMarkers()
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        viewModel.track(title: marker.title, at: marker.position)

        return false
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
        let markers = viewModel.loadMarkers()
        markers.forEach {
            self.createMarker(basedOn: $0)
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
