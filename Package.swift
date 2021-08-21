// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SLog",
    platforms: [.macOS(.v10_12), .iOS(.v10), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(
            name: "SLog",
            targets: ["SLog"]),
    ],
    targets: [
        .target(
            name: "SLog",
            dependencies: []),
        .testTarget(
            name: "SLogTests",
            dependencies: ["SLog"]),
    ]
)
