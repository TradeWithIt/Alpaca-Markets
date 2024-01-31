import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

public struct Market {
    public static let sandbox = Client(
        serverURL: URL(string: "https://data.sandbox.alpaca.markets")!,
        transport: URLSessionTransport()
    )

    public static let production = Client(
        serverURL: URL(string: "https://data.alpaca.markets")!,
        transport: URLSessionTransport()
    )
}
