// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "P42-watchos-widgets",
    platforms: [
        .watchOS(.v11)
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
            ]
        )
    ]
)
