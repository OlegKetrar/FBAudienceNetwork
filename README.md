# FBAudienceNetwork Swift PM wrapper

## What

This repository provides a **Swift Package Manager (SPM) wrapper** for the Facebook **FBAudienceNetwork** binary framework, enabling its use in SwiftPM projects.

## Why

Facebook distributes FBAudienceNetwork only via CocoaPods.  
There is no public repository with the binary framework, which makes SwiftPM integration difficult.  

This package solves that problem by providing a SPM-compatible binary target, so developers can use FBAudienceNetwork without relying on CocoaPods.  

Feature request to Facebook: [facebook-ios-sdk #2504](https://github.com/facebook/facebook-ios-sdk/issues/2504)

## How

The repository automates the creation of SwiftPM releases using the `ci` branch and `./release.sh` script. The process works as follows:

1. Fetch the latest version of FBAudienceNetwork from CocoaPods.
2. Check if this version is already released in this repository.
3. Zip fetched `.xcframework` and compute the checksum.
4. Update `Package.swift` with the new URL and checksum.
5. Push a GitHub release.

> **Note:** Only the `master` branch is user-facing and contains `Package.swift`.  
> The `ci` branch contains build scripts, intermediate files, and is used for automation.


## Usage

Add this package as a dependency in your `Package.swift`:

```swift
.package(
    url: "https://github.com/OlegKetrar/FBAudienceNetwork",
    from: "6.20.1"
)
```

## License

The wrapper and scripts are free to use, modify, and distribute for any purpose.  
The FBAudienceNetwork binary framework itself is copyrighted by Facebook.
