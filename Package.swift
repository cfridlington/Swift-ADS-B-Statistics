// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swift-ADS-B-Statistics",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Swift-ADS-B-Statistics",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]
        ),
        .testTarget(
            name: "Swift-ADS-B-Statistics-Tests",
            dependencies: ["Swift-ADS-B-Statistics"],
            resources: [
                    .copy("Resources/history_0.json"),
                    .copy("Resources/history_1.json"),
                    .copy("Resources/history_2.json"),
                    .copy("Resources/history_large.json"),
                    .copy("Resources/history_small.json"),
                    .copy("Resources/properties_medium.json"),
                    .copy("Resources/properties_small.json"),
                    .copy("Resources/flight_paths_1740891600.json")
                ]
        )
    ]
)
