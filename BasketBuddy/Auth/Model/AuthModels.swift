//
//  AuthModels.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

struct TokenResponse: Codable {
    struct User: Codable {
        let id: Int
        let email: String
    }

    let expiry: String?
    let token: String
    let user: User
}

struct AuthState: Codable {
    struct AuthTokenAndUser: Codable {
        let token: String
        let userId: Int
    }

    let data: AuthTokenAndUser?

    var isAuthenticated: Bool {
        return data != nil
    }
}
