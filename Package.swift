// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-gamecenter",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "swift-gamecenter",
            targets: ["GameCenterModule"]
        ),
    ],
    targets: [
        .target(
            name: "GameCenterModule"
        ),
        .testTarget(
            name: "GameCenterModuleTests",
            dependencies: ["GameCenterModule"]
        ),
        .testTarget(
            name: "GameCenterModulePublicTests",
            dependencies: ["GameCenterModule"]
        ),
    ]
)
