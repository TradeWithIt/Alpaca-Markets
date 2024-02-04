import OpenAPIRuntime
import OpenAPIAsyncHTTPClient
import HTTPTypes
import Foundation

public struct Broker {
    public enum Enviroment {
        case sandbox, live
        
        var path: String {
            switch self {
            case .sandbox:
                return "broker-api.sandbox"
            case .live:
                return "broker-api"
            }
        }
    }
    
    private static var shared: Broker = .init()
    
    private var authMiddleware: AuthenticationMiddleware? = nil
    private var env: Enviroment = .sandbox
    private var middlewares: [any ClientMiddleware] {
        guard let authMiddleware else { return [] }
        return [authMiddleware]
    }

    private var client: Client {
        Client(
            serverURL: URL(string: "https://\(env.path).alpaca.markets")!,
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
    
    public static func setApiKeys(username: String, password: String) {
        shared.authMiddleware = AuthenticationMiddleware(username: username, password: password)
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
