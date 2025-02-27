// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation

struct ADSBDBResponse: Codable {
    var response: ADSBDBAircraft
}

struct ADSBDBAircraft: Codable {
    var aircraft: AircraftProperties
}

struct AircraftProperties: Codable {
    var type: String
    var icao_type: String
    var manufacturer: String
    var registration: String
    var registered_owner_country_iso_name: String
    var registered_owner_country_name: String
    var registered_owner_operator_flag_code: String
    var registered_owner: String
    var url_photo: URL?
}
