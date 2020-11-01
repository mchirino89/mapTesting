//
//  MarkerInfoDTO.swift
//  mapTesting
//
//  Created by Mauricio Chirino on 31/10/20.
//

import Foundation

struct MarkerInfoDTO: Decodable {
    let latitude: Double
    let longitude: Double
    let title: String
    let snippet: String
}
