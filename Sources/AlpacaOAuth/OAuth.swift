import OpenAPIRuntime
import OpenAPIAsyncHTTPClient
import HTTPTypes
import Foundation

public struct OAuth {
    public enum Enviroment {
        case paper, live
        
        var path: String {
            switch self {
            case .paper:
                return "data.sandbox"
            case .live:
                return "data"
            }
        }
    }
    
    private static var shared: OAuth = .init()
    
    private var authMiddleware: AuthenticationMiddleware? = nil
    private var env: Enviroment = .paper
    private var middlewares: [any ClientMiddleware] {
        guard let authMiddleware else { return [] }
        return [authMiddleware]
    }

    private var client: Client {
        Client(
            serverURL: URL(string: "https://\(env.path).alpaca.markets/v2")!,
            transport: AsyncHTTPClientTransport(),
            middlewares: middlewares
        )
    }
    
    // MARK: Public Access
    
    public static var enviroment: Enviroment {
        get {
            shared.env
        }
        set {
            shared.env = newValue
        }
    }
    
    public static var client: Client {
        shared.client
    }
    
    public static func setApiKeys(apiKey: String, apiSecret: String) {
        shared.authMiddleware = AuthenticationMiddleware(apiKey: apiKey, apiSecret: apiSecret)
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
