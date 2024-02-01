// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Alpaca",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Alpaca",
            targets: ["AlpacaTrading", "AlpacaBroker", "AlpacaMarket", "AlpacaOAuth"]
        ),
    ],
    dependencies: [
            .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
            .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
            .package(url: "https://github.com/swift-server/swift-openapi-async-http-client", from: "1.0.0"),
        ],
    targets: [
        .target(
            name: "AlpacaBroker",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIAsyncHTTPClient", package: "swift-openapi-async-http-client"),
            ]
        ),
        .target(
            name: "AlpacaMarket",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIAsyncHTTPClient", package: "swift-openapi-async-http-client"),
            ]
        ),
        .target(
            name: "AlpacaOAuth",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIAsyncHTTPClient", package: "swift-openapi-async-http-client"),
            ]
        ),
        .target(
            name: "AlpacaTrading",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIAsyncHTTPClient", package: "swift-openapi-async-http-client"),
            ]
        ),
        
    ]
)
