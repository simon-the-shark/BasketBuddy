//
//  MainView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject private var authService: AuthService

    var body: some View {
        if authService.authState.isAuthenticated {
            ShoppingListsListView()
        } else {
            AuthView()
        }
    }
}

#Preview {
    MainView().environmentObject(AuthService())
}
