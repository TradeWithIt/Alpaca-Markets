// Generated by swift-openapi-generator, do not modify.
@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import struct Foundation.URL
@preconcurrency import struct Foundation.Data
@preconcurrency import struct Foundation.Date
#else
import struct Foundation.URL
import struct Foundation.Data
import struct Foundation.Date
#endif
import HTTPTypes
/// The OAuth API allows you to request market data and manage portfolios on behalf of your end-users.
///
/// For more information, visit https://alpaca.markets/docs/build-apps_services-with-alpaca/oauth-guide/.
public struct Client: APIProtocol {
    /// The underlying HTTP client.
    private let client: UniversalClient
    /// Creates a new client.
    /// - Parameters:
    ///   - serverURL: The server URL that the client connects to. Any server
    ///   URLs defined in the OpenAPI document are available as static methods
    ///   on the ``Servers`` type.
    ///   - configuration: A set of configuration values for the client.
    ///   - transport: A transport that performs HTTP operations.
    ///   - middlewares: A list of middlewares to call before the transport.
    public init(
        serverURL: Foundation.URL,
        configuration: Configuration = .init(),
        transport: any ClientTransport,
        middlewares: [any ClientMiddleware] = []
    ) {
        self.client = .init(
            serverURL: serverURL,
            configuration: configuration,
            transport: transport,
            middlewares: middlewares
        )
    }
    private var converter: Converter {
        client.converter
    }
    /// Bars
    ///
    /// The bars API returns aggregate historical data for the requested securities
    ///
    /// - Remark: HTTP `GET /v2/stocks/{symbol}/bars`.
    /// - Remark: Generated from `#/paths//v2/stocks/{symbol}/bars/get(getBarsStocks)`.
    public func getBarsStocks(_ input: Operations.getBarsStocks.Input) async throws -> Operations.getBarsStocks.Output {
        try await client.send(
            input: input,
            forOperation: Operations.getBarsStocks.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/v2/stocks/{}/bars",
                    parameters: [
                        input.path.symbol
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                try converter.setHeaderFieldAsURI(
                    in: &request.headerFields,
                    name: "Apca-Api-Key-Id",
                    value: input.headers.Apca_hyphen_Api_hyphen_Key_hyphen_Id
                )
                try converter.setHeaderFieldAsURI(
                    in: &request.headerFields,
                    name: "Apca-Api-Secret-Key",
                    value: input.headers.Apca_hyphen_Api_hyphen_Secret_hyphen_Key
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "start",
                    value: input.query.start
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "end",
                    value: input.query.end
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "timeframe",
                    value: input.query.timeframe
                )
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.getBarsStocks.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            OpenAPIRuntime.OpenAPIValueContainer.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Trades
    ///
    /// The Trades API provides historcial trade data for a given ticker symbol on a specified date. Returns trades for the queried stock signal.
    ///
    /// - Remark: HTTP `GET /v2/stocks/{symbol}/trades`.
    /// - Remark: Generated from `#/paths//v2/stocks/{symbol}/trades/get(getTradesStocks)`.
    public func getTradesStocks(_ input: Operations.getTradesStocks.Input) async throws -> Operations.getTradesStocks.Output {
        try await client.send(
            input: input,
            forOperation: Operations.getTradesStocks.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/v2/stocks/{}/trades",
                    parameters: [
                        input.path.symbol
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                try converter.setHeaderFieldAsURI(
                    in: &request.headerFields,
                    name: "Apca-Api-Key-Id",
                    value: input.headers.Apca_hyphen_Api_hyphen_Key_hyphen_Id
                )
                try converter.setHeaderFieldAsURI(
                    in: &request.headerFields,
                    name: "Apca-Api-Secret-Key",
                    value: input.headers.Apca_hyphen_Api_hyphen_Secret_hyphen_Key
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "start",
                    value: input.query.start
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "end",
                    value: input.query.end
                )
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.getTradesStocks.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            OpenAPIRuntime.OpenAPIValueContainer.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
}
