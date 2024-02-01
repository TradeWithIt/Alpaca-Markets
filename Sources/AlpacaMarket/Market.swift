import OpenAPIRuntime
import OpenAPIAsyncHTTPClient
import Foundation

public struct Market {
    public static let sandbox = Client(
        serverURL: URL(string: "https://data.sandbox.alpaca.markets")!,
        transport: AsyncHTTPClientTransport()
    )

    public static let production = Client(
        serverURL: URL(string: "https://data.alpaca.markets")!,
        transport: AsyncHTTPClientTransport()
    )
}
