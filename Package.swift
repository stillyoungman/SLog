// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SLog",
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
