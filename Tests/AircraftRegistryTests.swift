//
//  File.swift
//  Swift-ADS-B-Statistics
//
//  Created by Christopher Fridlington on 4/13/25.
//

import Foundation
import Testing
@testable import Swift_ADS_B_Statistics

class AircraftRegistryTests {
    
    var registry = AircraftRegistry(history: [:], lastUpdated: 0)
    let path = Bundle.module.resourcePath
    
    @Test func importRegistry() async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        registry.importRegistry(fromDirectory: unwrappedPath)
        
        #expect(registry.history.count == 4937)
    }
    
    @Test func updateRegistry() async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        registry.updateRegistry(fromDirectory: unwrappedPath, withNumberOfFiles: 1)
        
        #expect(registry.history.count == 2)
        
    }
}
