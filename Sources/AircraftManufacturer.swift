// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation

struct AircraftManufacturer: Codable {
    var name: String
    var types: [String : AircraftType]
}

struct AircraftType: Codable {
    var name: String
    var icao: String
    var aircraft: [String]
    var lastSeen: Double
}
