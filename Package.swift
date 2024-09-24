// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "P42-watchos-wdigets",
    platforms: [
        .iOS(.v15),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "P42-watchos-wdigets",
            targets: ["P42-watchos-wdigets"]),
    ],
    targets: [
        .target(
            name: "P42-watchos-wdigets"),
        .testTarget(
            name: "P42-watchos-wdigetsTests",
            dependencies: ["P42-watchos-wdigets"]),
    ]
)
