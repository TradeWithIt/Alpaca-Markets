import OpenAPIRuntime
import OpenAPIAsyncHTTPClient
import HTTPTypes
import Foundation

public struct Market {
    private static var shared: Market = .init()
    
    private var sandboxAuthMiddleware: AuthenticationMiddleware? = nil
    private var productionAuthMiddleware: AuthenticationMiddleware? = nil
    
    private var sandboxClient: Client {
        Client(
            serverURL: URL(string: "https://data.sandbox.alpaca.markets")!,
            transport: AsyncHTTPClientTransport(),
            middlewares: sandboxAuthMiddleware != nil ? [sandboxAuthMiddleware!] : []
        )
    }

    private var productionClient: Client {
        Client(
            serverURL: URL(string: "https://data.alpaca.markets")!,
            transport: AsyncHTTPClientTransport(),
            middlewares: productionAuthMiddleware != nil ? [productionAuthMiddleware!] : []
        )
    }
    
    // MARK: Public Access
    
    public static var sandbox: Client {
        shared.sandboxClient
    }
    
    public static var production: Client {
        shared.productionClient
    }
    
    public static func setSandboxApiKeys(apiKey: String, apiSecret: String) {
        shared.sandboxAuthMiddleware = AuthenticationMiddleware(apiKey: apiKey, apiSecret: apiSecret)
    }
    
    public static func setProductionApiKeys(apiKey: String, apiSecret: String) {
        shared.productionAuthMiddleware = AuthenticationMiddleware(apiKey: apiKey, apiSecret: apiSecret)
    }
}

// MARK: Helpers

private struct AuthenticationMiddleware: ClientMiddleware {
    var apiKey: String
    var apiSecret: String

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL
        ) async throws -> (HTTPResponse, HTTPBody?)) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        if let name = HTTPField.Name("APCA-API-KEY-ID") {
            request.headerFields[name] = apiKey
        }
        if let name = HTTPField.Name("APCA-API-SECRET-KEY") {
            request.headerFields[name] = apiSecret
        }
        return try await next(request, body, baseURL)
    }
}
