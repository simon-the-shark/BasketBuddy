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

        
        func login(with: AuthService) async {
            do {
                try await with.login(email: email, password: password)
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Login failed: \(error.localizedDescription)"
                }
            }
        }

        func signup(with: AuthService) async {
            do {
                try await with.signup(email: email, password: password)
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Signup failed: \(error.localizedDescription)"
                }
            }
        }
        
        func toggleIsLogginIn() {
            self.isLoggingIn = !isLoggingIn
        }
    }
}
