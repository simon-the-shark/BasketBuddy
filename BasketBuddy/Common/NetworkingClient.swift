//
//  NetworkingClient.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//
import Foundation

class EnvironmentValue {
    static func get(_ key: String) -> String? {
        return ProcessInfo.processInfo.environment[key]
    }
}

class NetworkingClient {
    static func getApiURL() -> URL {
        guard let apiUrlString = EnvironmentValue.get("API_URL"), let apiUrl = URL(string: apiUrlString) else {
            fatalError("Failed to initialize NetworkingClient: API_URL not set or invalid in environment")
        }
        return apiUrl
    }

    private let url: URL = getApiURL()

    private init() {}

    static let shared = NetworkingClient()

    func makeRequest(endpoint: String, method: String = "GET", headers: [String: String]? = nil, body: Data? = nil) async throws -> (Data, URLResponse) {
        if !endpoint.hasSuffix("/") {
            fatalError("Endpoint must end with '/'")
        }
        var request = URLRequest(url: url.appendingPathComponent(endpoint))
        request.httpMethod = method

        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = body {
            request.httpBody = body
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        return (data, response)
    }
}
