//
//  MapViewController.swift
//  mapTesting
//
//  Created by Mauricio Chirino on 26/10/20.
//

import CoreLocation
import UIKit

final class MapViewController: UIViewController {
    private let viewModel: MapViewModel
    private var mapContainer: MapViewProvidable

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: MapViewModel, mapContainer: MapViewProvidable = MapViewProvider()) {
        self.viewModel = viewModel
        self.mapContainer = mapContainer
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wireMapProvider()
        setupUI()
        addMarkers()
    }
}

extension MapViewController: MapProviderDelegate {
    func tapMarker(titled: String?, at coordinate: CLLocationCoordinate2D) {
        viewModel.track(title: titled, at: coordinate)
        viewModel.printTrackerInfo()
    }
}

private extension MapViewController {
    func wireMapProvider() {
        mapContainer.delegate = self
        mapContainer.animate(to: viewModel.cameraPosition)
    }

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mapContainer.mapView)
        setupMapUI()
    }

    func setupMapUI() {
        mapContainer.mapView.translatesAutoresizingMaskIntoConstraints = false
        mapContainer.mapView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        mapContainer.mapView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        mapContainer.mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        mapContainer.mapView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }

    func addMarkers() {
        let markers = viewModel.loadMarkers()

        markers.forEach {
            self.mapContainer.createMarker(basedOn: $0)
        }
    }
}
