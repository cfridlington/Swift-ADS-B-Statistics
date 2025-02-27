// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation

struct ManufacturerRegistry: Codable {
    
    var manufacturers : [String : AircraftManufacturer] = [:]
    
    mutating func importAircraft(fromRegistry registry: AircraftRegistry) {
        
        for aircraft in registry.history.values {
            
            if let properties = aircraft.properties {
                let type = AircraftType(name: properties.type, icao: properties.icao_type, aircraft: [aircraft.hex], lastSeen: aircraft.lastSeen)
                if manufacturers[properties.manufacturer] == nil {
                    manufacturers[properties.manufacturer] = AircraftManufacturer(name: properties.manufacturer, types: [properties.icao_type : type])
                } else {
                    if manufacturers[properties.manufacturer]!.types[properties.icao_type] == nil {
                        manufacturers[properties.manufacturer]!.types[properties.icao_type] = type
                    } else {
                        manufacturers[properties.manufacturer]!.types[properties.icao_type]!.aircraft.append(aircraft.hex)
                        if aircraft.lastSeen > manufacturers[properties.manufacturer]!.types[properties.icao_type]!.lastSeen {
                            manufacturers[properties.manufacturer]!.types[properties.icao_type]!.lastSeen = aircraft.lastSeen
                        }
                    }
                }
            }
            
        }
        
    }
    
    func export (toDirectory directoryPath: String) {
        let exportPath = "\(directoryPath)/aircraft_manufacturers.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(manufacturers)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
    }
    
    func getFrequentTypes () -> [AircraftType] {
        
        var types: [AircraftType] = []
        
        for (_, manufacturer) in manufacturers {
            for (_, type) in manufacturer.types {
                types.append(type)
            }
        }
        
        return types.sorted { ($0.aircraft.count, $0.lastSeen) > ($1.aircraft.count, $1.lastSeen) }
    }
    
    func exportFrequentTypes (toDirectory directoryPath: String, withMaximumCount n: Int) {
        let exportPath = "\(directoryPath)/aircraft_frequent_types.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes JSON readable
        
        let frequentTypes = getFrequentTypes()
        let topFrequentTypes = Array(frequentTypes[0..<n])
        
        do {
            let jsonData = try encoder.encode(topFrequentTypes)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
    }
}
