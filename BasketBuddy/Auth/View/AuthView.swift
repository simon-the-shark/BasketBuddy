//
//  AuthView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//


import Foundation
import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var authService: AuthService

    var body: some View {
        VStack {
            Text("Zalogowano: \(authService.authState.isAuthenticated)")
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if !viewModel.isLoggingIn {
                SecureField("Password Repeat", text: $viewModel.passwordRepeat)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            Button(action: {
                Task {
                    await viewModel.login(with: authService)
                }
            }) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Button(action: {
                Task {
                    await viewModel.signup(with: authService)
                }
            }) {
                Text("Signup")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Button(action: {
                viewModel.toggleIsLogginIn()
            }) {
                Text(viewModel.isLoggingIn ?
                     "Masz już konto? Zarejestruj się" : "Nie masz konta? Zaloguj się")
                    .padding()
            }


            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    AuthView().environmentObject(AuthService())
}
