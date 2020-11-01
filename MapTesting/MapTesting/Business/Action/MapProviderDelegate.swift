//
//  MapProviderDelegate.swift
//  MapTesting
//
//  Created by Mauricio Chirino on 01/11/20.
//

import CoreLocation

protocol MapProviderDelegate: class {
    func tapMarker(titled: String?, at coordinate: CLLocationCoordinate2D)
}
