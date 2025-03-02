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

struct Flights: Codable {
    
    var flights: [Double: FlightPath]

    // Custom encoding to ensure Double keys are stored as Strings
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringKey.self)
        for (key, value) in flights {
            try container.encode(value, forKey: StringKey(stringValue: String(key)))
        }
    }
    
    init (flights : [Double: FlightPath]) {
        self.flights = flights
    }

    // Custom decoding to convert String keys back to Doubles
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringKey.self)
        var decodedFlights: [Double: FlightPath] = [:]

        for key in container.allKeys {
            if let doubleKey = Double(key.stringValue) {
                decodedFlights[doubleKey] = try container.decode(FlightPath.self, forKey: key)
            }
        }
        self.flights = decodedFlights
    }

    // Helper struct to handle String keys
    struct StringKey: CodingKey {
        var stringValue: String
        var intValue: Int? { return nil }

        init(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            return nil
        }
    }
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
