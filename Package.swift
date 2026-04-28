// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CS_iOS_SDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ContentsquareModule",
            targets: ["ContentsquareModuleWrapper"]),
    ],
     dependencies: [
         .package(
             name: "CSSwiftProtobuf",
             url: "https://github.com/ContentSquare/CSSwiftProtobuf.git",
             .exact("1.33.3")),
         .package(
             name: "CSCrashReporter",
             url: "https://github.com/ContentSquare/CS_iOS_CrashReporter.git",
             .exact("1.0.1")),
         .package(
             name: "ContentsquareCore",
             url: "https://github.com/ContentSquare/apple-core-sdk.git",
             .exact("0.1.2")),
     ],
     targets: [
         // binaryTarget doesn't support dependency, use a wrapper to fix this.
         .target(
             name: "ContentsquareModuleWrapper",
             dependencies: [
                 .target(name: "ContentsquareModule"),
                 "CSSwiftProtobuf",
                 "CSCrashReporter",
                 "ContentsquareCore"
             ],
            path: "ContentsquareModuleWrapper",
            resources: [
                .process("ContentsquareBundle.bundle"),
                .copy("PrivacyInfo.xcprivacy")
            ]
        ),
        .binaryTarget(
            name: "ContentsquareModule",
            url: "https://github.com/ContentSquare/CS_iOS_SDK_DYNAMIC/releases/download/4.47.0-alpha.18/ContentsquareModuleSwiftPackageDynamic.xcframework.zip",
            checksum: "f97ac4c6e80a1423ce0a7d0b4935422e3fa14ed26162487867c2e502088fd7fc"),
    ]
)