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
            List {
                ForEach(Array(viewModel.groupProductsByCategory.keys), id: \.self) { category in
                    let products = viewModel.groupProductsByCategory[category] ?? []
                    Section(header: Text(category.name)) {
                        ForEach(products, id: \.self) { product in MyProductTile(product: product) }
                    }
                }
            }.navigationBarTitle("My Products")
                .navigationBarItems(trailing: Button(action: {
                    viewModel.logout(with: authService)
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Log Out")
                })
        }.onAppear {
            viewModel.loadProducts(with: authService)
        }
    }
}

#Preview {
    MyProductsView()
}
