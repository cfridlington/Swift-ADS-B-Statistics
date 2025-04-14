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
class FlightRegistryTests {
    
    let path = Bundle.module.resourcePath
    
    @Test
    func createRegistry() async throws {
        
        let registry = FlightPathRegistry()
        #expect(registry.paths.isEmpty)
    }
    
    @Test
    func importRegistry() async throws {
        let unwrappedPath = try #require(path, "Test data not found")
        
        var registry = FlightPathRegistry()
        registry.importRegistry(fromDirectory: unwrappedPath, testEpoch: 1740891600)
        
        #expect(registry.paths.count == 200)
    }
    
    @Test
    func updateRegistry() async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        
        var registry = FlightPathRegistry()
        registry.updateRegistry(fromDirectory: unwrappedPath, withNumberOfFiles: 3)
        
        #expect(registry.paths.count == 5)
    }
}
