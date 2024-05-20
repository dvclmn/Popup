// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Popup",
    
    platforms: [
        .iOS("17.0"),
        .macOS("14.0")
    ],
    products: [
        .library(
            name: "Popup",
            targets: ["Popup"]),
    ],
    dependencies: [
        .package(name: "StyleLibrary", path: "../StyleLibrary")
    ],
    targets: [
        .target(
            name: "Popup",
            dependencies: ["StyleLibrary"]
        ),
        .testTarget(
            name: "PopupTests",
            dependencies: ["Popup"]
        ),
    ]
)

