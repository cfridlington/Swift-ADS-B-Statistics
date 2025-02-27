// ADS-B Tracking History
// Created by Christopher Fridlington
// cfridlington.com

import Foundation

@main
struct Main {
    static func main() async {

        var registry = AircraftRegistry(history: [:], lastUpdated: 0)

        registry.importRegistry(fromDirectory: "/var/run/dump1090-mutability")
        registry.updateRegistry(fromDirectory: "/var/run/dump1090-mutability", withNumberOfFiles: 120)
        await registry.fetchAircraftProperties()
        registry.exportRegistry(toDirectory: "/var/run/dump1090-mutability")
    }
}
