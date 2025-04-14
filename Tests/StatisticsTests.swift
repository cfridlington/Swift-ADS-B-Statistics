//
//  File.swift
//  Swift-ADS-B-Statistics
//
//  Created by Christopher Fridlington on 4/13/25.
//

import Foundation
import Testing
@testable import Swift_ADS_B_Statistics

@Suite
class StatisticsTests {
    
    var statistics = Statistics()
    var aircraftRegistry = AircraftRegistry(history: [:], lastUpdated: 0)
    let path = Bundle.module.resourcePath
    
    @Test(arguments: zip(["history_small.json", "history_large.json"], [(1, "780a29", 2), (4937, "a470e3", 15266)]))
    func generateAircraftStatistics(filename: String, expectedValues: (Int, String, Int)) async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        aircraftRegistry.importRegistry(fromDirectory: unwrappedPath, filename: filename)
        
        statistics.generateStatistics(from: aircraftRegistry)
        
        #expect(statistics.aircraftSeen == expectedValues.0)
        #expect(statistics.mostFrequentAircraft.hex == expectedValues.1)
        #expect(statistics.totalFlights == expectedValues.2)
    }
    
    @Test(arguments: zip(["history_small.json", "history_large.json"], [(1, 1, "B748"), (216, 50, "B77W")]))
    func generateManufacturerStatistics(filename: String, expectedValues: (Int, Int, String)) async throws {
        let unwrappedPath = try #require(path, "Test data not found")
        aircraftRegistry.importRegistry(fromDirectory: unwrappedPath, filename: filename)
        
        var manufacturerRegistry = ManufacturerRegistry()
        manufacturerRegistry.importAircraft(fromRegistry: aircraftRegistry)
        
        statistics.generateStatistics(from: manufacturerRegistry)
        
        #expect(statistics.typesSeen == expectedValues.0)
        #expect(statistics.totalManufacturers == expectedValues.1)
        #expect(statistics.mostFrequentType.icao == expectedValues.2)
    }
}
