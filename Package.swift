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
            targets: ["Popup"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.3.3")
    ],
    targets: [
        .target(
            name: "Popup", dependencies: [.product(name: "Dependencies", package: "swift-dependencies")]
        )
    ]
)

