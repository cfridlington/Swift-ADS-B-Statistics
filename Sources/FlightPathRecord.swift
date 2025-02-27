//
//  FlightPathRecord.swift
//  Swift-ADS-B-Statistics
//
//  Created by Christopher Fridlington on 2/27/25.
//

struct FlightPathRecord: Codable {
    var now: Double
    var messages: Int
    var aircraft: [FlightPathMessage]
}

struct FlightPath: Codable {
    var adsb: String
    var messages: [FlightPathPosition]
}

struct FlightPathMessage: Codable {
    var adsb: String
    var latitude: Double?
    var longitude: Double?
    var time: Double
    
    var positionReported: Bool {
        return latitude != nil && longitude != nil
    }
    
    enum CodingKeys: String, CodingKey {
        case adsb = "hex"
        case latitude = "lat"
        case longitude = "lon"
        case time = "seen"
    }
}

struct FlightPathPosition: Codable {
    var latitude: Double
    var longitude: Double
}
