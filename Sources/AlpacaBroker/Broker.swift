import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

public struct Broker {
    public static let sandbox = Client(
        serverURL: URL(string: "https://broker-api.sandbox.alpaca.markets")!,
        transport: URLSessionTransport()
    )
    
    public static let production = Client(
        serverURL: URL(string: "https://broker-api.alpaca.markets")!,
        transport: URLSessionTransport()
    )
}
