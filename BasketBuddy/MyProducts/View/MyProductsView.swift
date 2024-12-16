//
//  MyProductsView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import SwiftUI

struct MyProductsView: View {
    @EnvironmentObject private var authService: AuthService
    @StateObject private var viewModel: ViewModel = .init()

    var body: some View {
        NavigationView {
            List {}
                .navigationBarTitle("My Products")
                .navigationBarItems(trailing: Button(action: {
                    viewModel.logout(with: authService)
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Log Out")
                })
        }
    }
}

#Preview {
    MyProductsView()
}
