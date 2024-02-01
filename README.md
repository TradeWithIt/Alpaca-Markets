# ALPACA MARKETS APIs

Generated from [OpenAPI](https://github.com/alpacahq/alpaca-docs/blob/master/oas/oauth/openapi.yaml) using [Swift OpenAPI Generator](https://www.swift.org/blog/introducing-swift-openapi-generator/) 


[Open API Explores](https://tradewithit.github.io/Alpaca-Markets/index.html)

This repository was generated using swift package command 
```
swift package plugin generate-code-from-openapi --target Broker

swift package plugin generate-code-from-openapi --target Market

swift package plugin generate-code-from-openapi --target OAuth

swift package plugin generate-code-from-openapi --target Trading
```

This generated files into the GreetingServiceClient target’s Sources directory, in a directory called GeneratedSources, which has been check into this repository.

## Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding a dependency is as easy as adding it to the dependencies value of your Package.swift.

Add the package dependency in your Package.swift:
```
dependencies: [
    .package(url: "https://github.com/TradeWithIt/alpaca", from: "1.0.0")
]
```
Next, in your target, add OpenAPIURLSession to your dependencies:
```
.target(name: "MyTarget", dependencies: [
    .product(name: "Alpaca", package: "Alpaca"),
]),
```

## Usage 

Example use:
```
do {
    let result = try await Trading.sandbox.addAssetToWatchlist(path: .init(watchlist_id: ""))
} catch {
    print(error)
}
```
