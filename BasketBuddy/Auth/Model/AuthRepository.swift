//
//  AuthRepository.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

class AuthRepository {
    private let remoteRepository: RemoteAuthRepository = .init()
    private let localRepository: LocalAuthRepository = .init()

    private init() {}

    static let shared: AuthRepository = .init()

    func getAuthState() throws -> AuthState {
        let (token, userId) = try localRepository.getTokenAndUser()
        guard let token = token else {
            return AuthState(data: nil)
        }
        guard let userId = userId else {
            return AuthState(data: nil)
        }
        return AuthState(data: .init(token: token, userId: userId))
    }

    func login(email: String, password: String) async throws -> AuthState {
        let (token, userId) = try await remoteRepository.loginForToken(email: email, password: password)
        try localRepository.saveTokenAndUser(token, userId: userId)
        return AuthState(data: .init(token: token, userId: userId))
    }

    func signup(email: String, password: String) async throws -> AuthState {
        let (token, userId) = try await remoteRepository.signupForToken(email: email, password: password)
        try localRepository.saveTokenAndUser(token, userId: userId)
        return AuthState(data: .init(token: token, userId: userId))
    }
    
    func logout() async throws -> AuthState {
        try await remoteRepository.logout(currAuth: getAuthState())
        try localRepository.deleteTokenAndUser()
        return AuthState(data: nil)
    }
}
