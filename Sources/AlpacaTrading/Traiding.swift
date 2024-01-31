import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

public struct Trading {
    public static let sandbox = Client(
        serverURL: URL(string: "https://paper-api.alpaca.markets")!,
        transport: URLSessionTransport()
    )
    
    public static let production = Client(
        serverURL: URL(string: "https://api.alpaca.markets")!,
        transport: URLSessionTransport()
    )
}