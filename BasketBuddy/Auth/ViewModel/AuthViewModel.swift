//
//  AuthViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation
import SwiftUI

extension AuthView {
    class ViewModel: ObservableObject {
        @Published var errorMessage: String?

        @Published var email = ""
        @Published var password = ""
        @Published var passwordRepeat = ""
        @Published var isLoggingIn = true
        @Published var isLoading = false

        func login(with: AuthService) async {
            Task {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                do {
                    try await with.login(email: email, password: password)
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Login failed: \(error.localizedDescription)"
                    }
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }

        func signup(with: AuthService) async {
            Task {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                do {
                    try await with.signup(email: email, password: password)
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Signup failed: \(error.localizedDescription)"
                    }
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }

        func toggleIsLogginIn() {
            isLoggingIn = !isLoggingIn
        }
    }
}
