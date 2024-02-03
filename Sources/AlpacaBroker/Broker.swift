import OpenAPIRuntime
import OpenAPIAsyncHTTPClient
import HTTPTypes
import Foundation

public struct Broker {
    private static var shared: Broker = .init()
    
    private var sandboxAuthMiddleware: AuthenticationMiddleware? = nil
    private var productionAuthMiddleware: AuthenticationMiddleware? = nil
    
    private var sandboxClient: Client {
        Client(
            serverURL: URL(string: "https://broker-api.sandbox.alpaca.markets")!,
            transport: AsyncHTTPClientTransport(),
            middlewares: sandboxAuthMiddleware != nil ? [sandboxAuthMiddleware!] : []
        )
    }

    private var productionClient: Client {
        Client(
            serverURL: URL(string: "https://broker-api.alpaca.markets")!,
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
    
    public static func setSandboxBasicAuth(username: String, password: String) {
        shared.sandboxAuthMiddleware = AuthenticationMiddleware(username: username, password: password)
    }
    
    public static func setProductionBasicAuth(username: String, password: String) {
        shared.productionAuthMiddleware = AuthenticationMiddleware(username: username, password: password)
    }
}

// MARK: Helpers

private struct AuthenticationMiddleware: ClientMiddleware {
    var username: String
    var password: String

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL
        ) async throws -> (HTTPResponse, HTTPBody?)) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        let base64 = try "\(username):\(password)".base64Decoded()
        request.headerFields[.authorization] = "Basic \(base64)"
        return try await next(request, body, baseURL)
    }
}
