// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "P42-watchos-widgets",
    platforms: [
        .iOS(.v15),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "P42-watchos-widgets",
            targets: ["P42-watchos-widgets"]),
    ],
    targets: [
        .target(
            name: "P42-watchos-widgets"),
        .testTarget(
            name: "P42-watchos-widgetsTests",
            dependencies: ["P42-watchos-widgets"]),
    ]
)
