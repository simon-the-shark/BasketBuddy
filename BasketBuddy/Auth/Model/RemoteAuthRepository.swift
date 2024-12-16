//
//  RemoteAuthRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

class RemoteAuthRepository {
    private func getToken(email: String, password: String, endpoint: String) async throws -> (String, Int) {
        let parameters = ["email": email, "password": password]
        let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let (data, response) = try await NetworkingClient.shared.makeRequest(endpoint: endpoint, method: "POST", body: jsonData)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
        return (tokenResponse.token, tokenResponse.user.id)
    }

    func signupForToken(email: String, password: String) async throws -> (String, Int) {
        return try await getToken(email: email.lowercased(), password: password, endpoint: "/api/v1/auth/signup/")
    }

    func loginForToken(email: String, password: String) async throws -> (String, Int) {
        return try await getToken(email: email.lowercased(), password: password, endpoint: "/api/v1/auth/login/")
    }

    func logout(currAuth: AuthState) async throws {
        let (data, response) = try await NetworkingClient.shared.makeRequest(endpoint: "/api/v1/auth/logout/", method: "POST", headers: [
            "Authorization": "Token \(currAuth.tokenRequired)"])
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}
