//
//  FlightPathRegistry.swift
//  Swift-ADS-B-Statistics
//
//  Created by Christopher Fridlington on 2/27/25.
//

import Foundation

struct FlightPathRegistry: Codable {
    
    var paths: [String : Flights] = [:]
    
    mutating func updateRegistry (fromDirectory directoryPath: String, withNumberOfFiles numberOfFiles: Int) {
        for n in 0..<numberOfFiles {
            let filePath = "\(directoryPath)/history_\(n).json"
            do {
                let fileData = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let decoder = JSONDecoder()
                let record = try decoder.decode(FlightPathRecord.self, from: fileData)
                
                for message in record.aircraft {
                    if message.positionReported {
                        
                        let time = message.time + record.now
                        let flightMessage = FlightPathPosition(latitude: message.latitude!, longitude: message.longitude!)
                        let flightPath = FlightPath(adsb: message.adsb, messages: [flightMessage])
                        
                        if paths[message.adsb] == nil {
                            paths[message.adsb] = Flights(flights: [time: flightPath])
                        } else {
                            if paths[message.adsb]!.flights.keys.allSatisfy({ time > $0 + 3600 }) {
                                paths[message.adsb]!.flights[time] = flightPath
                            } else {
                                if let existingKey = paths[message.adsb]!.flights.keys.min(by: { abs($0 - time) < abs($1 - time) }) {
                                    paths[message.adsb]!.flights[existingKey]!.messages.append(flightMessage)
                                }
                            }
                        }
                    }
                }
            }
            catch {
                 print("Error decoding history_\(n).json: \(error)")
            }
        }
    }
    
    private func importOverview (fromDirectory directoryPath: String) -> [Int] {
        let importPath = "\(directoryPath)/flight_paths/flight_paths_overview.json"
        let decoder = JSONDecoder()
        
        do {
            let fileData = try Data(contentsOf: URL(fileURLWithPath: importPath))
            let dates = try decoder.decode([Int].self, from: fileData)
            return dates
        }
        catch {
            return []
        }
    }
    
    private func exportOverview (dates: [Int], toDirectory directoryPath: String) {
        let exportPath = "\(directoryPath)/flight_paths/flight_paths_overview.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted 
        
        do {
            let jsonData = try encoder.encode(dates)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
    }
    
    mutating func importRegistry (fromDirectory directoryPath: String) {
        let calendar = Calendar.current
        let todayEpoch = Int(calendar.startOfDay(for: Date()).timeIntervalSince1970)
        
        let importPath = "\(directoryPath)/flight_paths/flight_paths_\(todayEpoch).json"
        let decoder = JSONDecoder()
        do {
            let fileData = try Data(contentsOf: URL(fileURLWithPath: importPath))
            let decodedPaths = try decoder.decode([String : Flights].self, from: fileData)
            paths = decodedPaths
        }
        catch let error as NSError {
            print("Error reading file: \(error)")
        }
        
    }
    
    func exportRegistry (toDirectory directoryPath: String) {
        let calendar = Calendar.current
        let todayEpoch = Int(calendar.startOfDay(for: Date()).timeIntervalSince1970)

        let exportPath = "\(directoryPath)/flight_paths/flight_paths_\(todayEpoch).json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes JSON readable
            
        do {
            let jsonData = try encoder.encode(paths)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
        
        var dates = importOverview(fromDirectory: directoryPath)
        if !dates.contains(where: { $0 == todayEpoch }) {
            dates.append(todayEpoch)
            exportOverview(dates: dates, toDirectory: directoryPath)
        }
        
        
    }
    
}
