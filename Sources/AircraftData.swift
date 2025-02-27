// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation

struct AircraftData: Codable {
    var hex: String
    var flights: [String:Int]
    var lastSeen: Double
    var timesSeen: [Double]
    var properties: AircraftProperties?
    
    mutating func addFlight(_ flight: String, at time: Double) {
        if flights.isEmpty {
            flights = [flight:1]
            addFlight(at: time)
        } else {
            
            if timesSeen.isEmpty {
                timesSeen.append(time)
            } else {
                
                if timesSeen.allSatisfy({ time > $0 + 3600 }) {
                    if flights[flight] == nil {
                        flights[flight] = 1
                    } else {
                        flights[flight]! += 1
                    }
                    timesSeen.append(time)
                }
            }
        }
        self.updateLastSeen(time)
    }
    
    mutating func addFlight(at time: Double) {
        if timesSeen.isEmpty {
            timesSeen.append(time)
        } else {
            if timesSeen.allSatisfy({ time > $0 + 3600 }) {
                timesSeen.append(time)
            }
        }
        self.updateLastSeen(time)
    }
    
    mutating private func updateLastSeen(_ time: Double) {
        if time > lastSeen {
            lastSeen = time
        }
    }
}
