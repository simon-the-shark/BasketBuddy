//
//  AuthService.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//
import Foundation

class AuthService: ObservableObject {
    @Published var authState: AuthState = .init(data: nil)

    private let authRepository = AuthRepository.shared

    init() {
        do {
            authState = try authRepository.getAuthState()
        } catch {
            authState = .init(data: nil)
        }
    }

    func login(email: String, password: String) async throws {
        let authState = try await authRepository.login(email: email, password: password)
        DispatchQueue.main.async {
            self.authState = authState
        }
    }

    func signup(email: String, password: String) async throws {
        let authState = try await authRepository.signup(email: email, password: password)
        DispatchQueue.main.async {
            self.authState = authState
        }
    }

    func logout() async throws {
        let authState = try await authRepository.logout()
        DispatchQueue.main.async {
            self.authState = authState
        }
    }
}
