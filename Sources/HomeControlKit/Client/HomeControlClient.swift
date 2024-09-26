//
//  HomeControlClient.swift
//  HomeControlKit
//
//  Created by Christoph Pageler on 30.04.24.
//

import Foundation

public struct HomeControlClient {
    public let baseURL: URL
    public var authToken: String?

    public var inverterReading: InverterReadingRoutes { .init(handler: self) }
    public var pushDevice: PushDeviceRoutes { .init(handler: self) }
    public var webSocket: WebSocketRoutes { .init(handler: self) }

    public init?(address: String, port: Int) {
        guard let url = URL(string: "http://\(address):\(port)") else { return nil }
        baseURL = url
    }

    public static var localhost: Self { HomeControlClient(address: "127.0.0.1", port: 8080)! }
}

extension HomeControlClient: NetworkClientHandler {
    func urlRequest(for url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        addAuthToken(urlRequest: &urlRequest)
        return urlRequest
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        var request = request
        addAuthToken(urlRequest: &request)

        return try await URLSession.shared.data(for: request)
    }

    private func addAuthToken(urlRequest: inout URLRequest) {
        guard let authToken else { return }
        urlRequest.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
    }
}
