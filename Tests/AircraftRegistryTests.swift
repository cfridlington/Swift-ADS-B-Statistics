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
class AircraftRegistryTests {
    
    var registry = AircraftRegistry(history: [:], lastUpdated: 0)
    let path = Bundle.module.resourcePath
    
    
    @Test(arguments: zip(["history_small.json", "history_large.json"], [1, 4937]))
    func importRegistry(filename: String, aircraftCount: Int) async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        registry.importRegistry(fromDirectory: unwrappedPath, filename: filename)
        
        #expect(registry.history.count == aircraftCount)
    }
    
    @Test(arguments: zip(["history_small.json", "history_large.json"], [3, 4937]))
    func updateRegistry(filename: String, aircraftCount: Int) async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        registry.importRegistry(fromDirectory: unwrappedPath, filename: filename)
        registry.updateRegistry(fromDirectory: unwrappedPath, withNumberOfFiles: 1)
        
        #expect(registry.history.count == aircraftCount)
    }
    
    @Test(arguments: zip(["properties_small.json", "properties_medium.json"], [1, 8]))
    func fetchProperties(filename: String, expectedAircraftWithProperties: Int) async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        registry.importRegistry(fromDirectory: unwrappedPath, filename: filename)
        await registry.fetchAircraftProperties()
        
        let aircraftWithProperties = registry.history.filter { $0.value.properties != nil }
        
        #expect(aircraftWithProperties.count == expectedAircraftWithProperties)
    }
}
