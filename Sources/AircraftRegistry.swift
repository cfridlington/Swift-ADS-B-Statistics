// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AircraftRegistry: Codable {
    var history: [String: AircraftData]
    var lastUpdated: Double
    
    mutating func importRegistry (fromDirectory directoryPath: String) {
        let filePath = "\(directoryPath)/history_complete.json"
        do {
            let fileData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let decoder = JSONDecoder()
            let registry = try decoder.decode(AircraftRegistry.self, from: fileData)
            history = registry.history
            lastUpdated = registry.lastUpdated
        } catch let error as NSError {
            print("Error decoding history_complete.json: \(error)")
        }
    }
    
    mutating func updateRegistry (fromDirectory directoryPath: String, withNumberOfFiles numberOfFiles: Int) {
        for n in 0..<numberOfFiles {
            let filePath = "\(directoryPath)/history_\(n).json"
            do {
                let fileData = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let decoder = JSONDecoder()
                let record = try decoder.decode(HistoryRecord.self, from: fileData)
                
                for aircraft in record.aircraft {
                    
                    if history[aircraft.hex] == nil {
                        history[aircraft.hex] = AircraftData(hex: aircraft.hex, flights: [:], lastSeen: (record.now + aircraft.seen), timesSeen: [])
                    }
                    
                    if aircraft.flight != nil {
                        history[aircraft.hex]!.addFlight(aircraft.flight!, at: (record.now + aircraft.seen))
                    } else {
                        history[aircraft.hex]!.addFlight(at: (record.now + aircraft.seen))
                    }
                }
                
                lastUpdated = Date.now.timeIntervalSince1970
                
            }
            catch let error as NSError {
                 print("Error decoding history_\(n).json: \(error)")
            }
        }
    }
    
    func exportRegistry (toDirectory directoryPath: String) {
        let exportPath = "\(directoryPath)/history_complete.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes JSON readable
            
        do {
            let jsonData = try encoder.encode(self)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
    }
    
    mutating func fetchAircraftProperties () async {
        for (hex, aircraft) in history {
            if aircraft.properties == nil {
                let url = URL(string: "https://api.adsbdb.com/v0/aircraft/\(hex)")!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    if let decodedResponse = try? JSONDecoder().decode(ADSBDBResponse.self, from: data) {
                        history[hex]!.properties = decodedResponse.response.aircraft
                    }
                } catch {
                    print("Error Fetching from ADSB-DB: \(error)")
                }
            }
        }
    }
    
    func getFrequentTails() -> [AircraftData] {
        return history.values.sorted { ($0.timesSeen.count, $0.lastSeen) > ($1.timesSeen.count, $1.lastSeen) }
    }
    
    func exportFrequentTails (toDirectory directoryPath: String, withMaximumCount n: Int) {
        let exportPath = "\(directoryPath)/aircraft_frequent_tails.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes JSON readable
        
        let frequentTails = getFrequentTails()
        let topFrequentTails = Array(frequentTails[0..<n])
        
        do {
            let jsonData = try encoder.encode(topFrequentTails)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
    }
    
    func exportRecentlyTracked (toDirectory directoryPath: String, withMaximumCount n: Int) {
        let exportPath = "\(directoryPath)/aircraft_recently_tracked.json"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes JSON readable
        
        let recentlyTracked = Array((history.values.sorted { $0.lastSeen > $1.lastSeen })[0..<n])
        
        do {
            let jsonData = try encoder.encode(recentlyTracked)
            try jsonData.write(to: URL(fileURLWithPath: exportPath))
        } catch {
            print("Error writing to file: \(error)")
        }
    }
}
