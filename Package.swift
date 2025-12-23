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
    dependencies: [
        .package(url: "git@github.com:platform-42/P42-extensions.git", branch: "main")
    ],
    targets: [
        .target(
            name: "P42-watchos-widgets",
            dependencies: [
                "P42-extensions"
            ],
            path: "Sources/P42-watchos-widgets"
        )
    ]
)
