// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation

@main
struct Main {
    static func main() async {

        var aircraftRegistry = AircraftRegistry(history: [:], lastUpdated: 0)

        aircraftRegistry.importRegistry(fromDirectory: "/var/run/dump1090-mutability")
        aircraftRegistry.updateRegistry(fromDirectory: "/var/run/dump1090-mutability", withNumberOfFiles: 120)
        await aircraftRegistry.fetchAircraftProperties()
        aircraftRegistry.exportRegistry(toDirectory: "/var/run/dump1090-mutability")
        aircraftRegistry.exportFrequentTails(toDirectory: "/var/run/dump1090-mutability", withMaximumCount: 10)
        aircraftRegistry.exportRecentlyTracked(toDirectory: "/var/run/dump1090-mutability", withMaximumCount: 10)
        
        var manufacturerRegistry = ManufacturerRegistry()
        manufacturerRegistry.importAircraft(fromRegistry: aircraftRegistry)
        manufacturerRegistry.export(toDirectory: "/var/run/dump1090-mutability")
        manufacturerRegistry.exportFrequentTypes(toDirectory: "/var/run/dump1090-mutability", withMaximumCount: 10)
    }
}
