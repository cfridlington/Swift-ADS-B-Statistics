//
//  Statistics.swift
//  Swift-ADS-B-Statistics
//
//  Created by Christopher Fridlington on 2/27/25.
//

import Foundation

struct Statistics: Codable {
    
    var totalFlights: Int = 0
    var totalCallsigns: Int = 0
    var typesSeen: Int = 0
    var aircraftSeen: Int = 0
    var totalManufacturers: Int = 0
    var mostFrequentType: AircraftType = AircraftType(name: "", icao: "", aircraft: [], lastSeen: 0)
    var mostFrequentAircraft: AircraftData = AircraftData(hex: "", flights: [:], lastSeen: 0, timesSeen: [])
    
    mutating func generateStatistics(from registry: AircraftRegistry) {
        aircraftSeen = registry.history.count
        
        for aircraft in registry.history.values {
            totalFlights += aircraft.timesSeen.count
            totalCallsigns += aircraft.flights.count
        }
        
        mostFrequentAircraft = registry.getFrequentTails().first!
    }
    
    mutating func generateStatistics(from manufacturers: ManufacturerRegistry) {
        totalManufacturers = manufacturers.manufacturers.count
        
        for manufacturer in manufacturers.manufacturers.values {
            typesSeen += manufacturer.types.count
        }
        
        mostFrequentType = manufacturers.getFrequentTypes().first!
    }
    
    func export (toDirectory directoryPath: String) {
        let exportPath = "\(directoryPath)/statistics.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes JSON readable
            
        do {
            let jsonData = try encoder.encode(self)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
    }
}
