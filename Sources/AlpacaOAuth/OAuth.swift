import OpenAPIRuntime
import OpenAPIAsyncHTTPClient
import Foundation

public struct OAuth {
    public static let sandbox = Client(
        serverURL: URL(string: "https://data.sandbox.alpaca.markets/v2")!,
        transport: AsyncHTTPClientTransport()
    )

    public static let production = Client(
        serverURL: URL(string: "https://data.alpaca.markets/v2")!,
        transport: AsyncHTTPClientTransport()
    )
}
