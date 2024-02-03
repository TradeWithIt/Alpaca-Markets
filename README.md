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
    .package(url: "https://github.com/TradeWithIt/Alpaca-Markets", from: "1.0.2")
]
```
Next, in your target, add OpenAPIURLSession to your dependencies:
```
.target(name: "MyTarget", dependencies: [
    .product(name: "Alpaca", package: "Alpaca"),
]),
```

### Import any target you want to use:
Open brokerage accounts, enable crypto and stock trading, and manage the ongoing user experience with Alpaca Broker API
```
import AlpacaBroker
```
Access Alpaca’s historical and real-time US stock market and crypto data through REST API and WebSocket. There are APIs for Stock Pricing, Crypto Pricing, and News.
```
import AlpacaMarket
```
The OAuth API allows you to request market data and manage portfolios on behalf of your end-users.

For more information, visit [oauth-guide](https://alpaca.markets/docs/build-apps_services-with-alpaca/oauth-guide/.)
```
import AlpacaOAuth
```
Alpaca's Trading API is a modern platform for algorithmic trading.

For complete documentation on the Trading API and to obtain your keys head to https://alpaca.markets/docs/api-documentation/api-v2/. Once you have your keys, head to the environments tab to quickly get started.
```
import AlpacaTrading
```


## Usage 
Set auth:
```
import AlpacaMarket


Market.setSandboxApiKeys(
    apiKey: "",
    apiSecret: ""
)
```

Example use:
```
import AlpacaMarket


do {
    let response = try await Market.sandbox.getBarsForStockSymbol(
        .init(
            path: .init(symbol: "AAPL"),
            query: .init(timeframe: "1min")
        )
    )
    
    switch response {
    case .ok(let okResponse):
        // Switch over the response content type.
        switch okResponse.body {
        case .json(let bars):
            // Print the greeting message.
            print("👋 \(bars.symbol)")
            print("👋 \(bars.next_page_token)")
            let candles = bars.bars.map({ Candle(from: $0) })
            await MainActor.run {
                self.candles = candles
            }
        }
    case .undocumented(statusCode: let statusCode, _):
        // Handle HTTP response status codes not documented in the OpenAPI document.
        print("🥺 undocumented response: \(statusCode)")
    }
    
} catch {
    print(error)
}
```
