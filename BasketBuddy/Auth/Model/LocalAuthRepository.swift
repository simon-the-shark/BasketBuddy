//
//  LocalAuthRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

class LocalAuthRepository {
    private let keychainRepository: KeychainClient = .init(service: "com.bundle.stuff.token-service")
    private let identifierToken = "basket-buddy-user-auth-token"
    private let identifierUserId = "basket-budder-user-auth-id"

    func saveTokenAndUser(_ token: String, userId: Int) throws {
        guard let tokenData = token.data(using: .utf8) else {
            throw NSError(domain: "Invalid token format", code: 0, userInfo: nil)
        }
        let userData = Data("\(userId)".utf8)
        try keychainRepository.upsertToken(tokenData, identifier: identifierToken)
        try keychainRepository.upsertToken(userData, identifier: identifierUserId)
    }

    func getTokenAndUser() throws -> (String?, Int?) {
        let token = try keychainRepository.getTokenOrNull(identifier: identifierToken)
        if let userId = try keychainRepository.getTokenOrNull(identifier: identifierUserId) {
            return (token, Int(userId))
        }
        return (token, nil)
    }

    func deleteTokenAndUser() throws {
        try keychainRepository.deleteToken(identifier: identifierToken)
        try keychainRepository.deleteToken(identifier: identifierUserId)
    }
}
