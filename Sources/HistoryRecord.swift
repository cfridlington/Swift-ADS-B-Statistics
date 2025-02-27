// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation

struct HistoryRecord: Codable {
    var now: Double
    var messages: Int
    var aircraft: [AircraftRecord]
}

struct AircraftRecord: Codable {
    var hex: String
    var flight: String?
    var seen: Double
}
