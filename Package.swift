// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let gameName = "AnimalBoxing"

let package = Package(
    name: gameName,
    platforms: [
        .macOS("10.15")
    ],
    dependencies: [
        .package(url: "https://github.com/STREGAsGate/Raylib.git", branch: "master"),
        .package(url: "git@github.com:MarcoEidinger/OSInfo.git", exact: "1.0.1"),
        .package(name: "CastleEngine", path: "../castle"),
    ],
    targets: [
        .executableTarget(
            name: gameName,
            dependencies: [
                .product(name: "CastleEngine", package: "CastleEngine"),
                .product(name: "OSInfo", package: "OSInfo")
            ]
        ),
    ]
)
