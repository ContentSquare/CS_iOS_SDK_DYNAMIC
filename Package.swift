// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CS_iOS_SDK",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
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
             .exact("dad3cdfa65dc7054c6fbfe8035d24ac9623c6266")),
         .package(
             name: "ContentsquareUICore",
             url: "https://github.com/contentsquare/ios-ui-core-sdk.git",
             .exact("0.3.0")),
     ],
     targets: [
         // binaryTarget doesn't support dependency, use a wrapper to fix this.
         .target(
             name: "ContentsquareModuleWrapper",
             dependencies: [
                 .target(name: "ContentsquareModule", condition: .when(platforms: [ .iOS ])),
                 "CSSwiftProtobuf",
                 .product(name: "CSCrashReporter", package: "CSCrashReporter", condition: .when(platforms: [ .iOS ])),
                 "ContentsquareCore",
                 .product(name: "ContentsquareUICore", package: "ContentsquareUICore", condition: .when(platforms: [ .iOS, .macCatalyst ]))
             ],
            path: "ContentsquareModuleWrapper",
            resources: [
                .copy("ContentsquareBundle.bundle"),
                .copy("PrivacyInfo.xcprivacy")
            ]
        ),
        .binaryTarget(
            name: "ContentsquareModule",
            url: "https://github.com/ContentSquare/CS_iOS_SDK_DYNAMIC/releases/download/4.54.0-alpha.6/ContentsquareModuleSwiftPackageDynamic.xcframework.zip",
            checksum: "c60726778aa77f40e26b8d42b154a0152ef5aa9d9f3d1223d8319bd04aad60ac"),
    ]
)