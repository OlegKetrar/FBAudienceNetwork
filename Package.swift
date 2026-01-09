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
        checksum: "05c22adf4ac10d90ad91525aa4296717ecd6a1ea1a314bdb240d40045c68937c"
      )
    ]
)