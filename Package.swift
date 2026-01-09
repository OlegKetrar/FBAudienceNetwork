// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FBAudienceNetwork",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "FBAudienceNetwork",
            targets: ["FBAudienceNetwork"]),
    ],
    targets: [
      .binaryTarget(
        name: "FBAudienceNetwork",
        url: "https://github.com/OlegKetrar/FBAudienceNetwork/releases/download/6.20.1/FBAudienceNetwork.xcframework.zip",
        checksum: "1e2e57194498010bf0179eb2feb838e425f28a7fc434e8c1b30bc409e241b365"
      )
    ]
)