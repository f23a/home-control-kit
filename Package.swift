// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "home-control-kit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "HomeControlKit",
            targets: ["HomeControlKit"]
        )
    ],
    targets: [
        .target(
            name: "HomeControlKit"
        ),
        .testTarget(
            name: "HomeControlKitTests",
            dependencies: ["HomeControlKit"]
        )
    ]
)
