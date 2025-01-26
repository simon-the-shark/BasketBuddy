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
                        ForEach(products, id: \.self) { product in  NavigationLink {
                            MyProductsFormView(product: product, categories: viewModel.categories) {
                                viewModel.loadProducts(with: authService)
                            }
                        } label: {
                            StorageImage(image: product.image, category: product.category, imageDimensionSize: 50)
                            Text(product.name)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
 }
                    }
                }
                NavigationLink{
                    MyProductsFormView(categories: viewModel.categories) {
                        viewModel.loadProducts(with: authService)
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Dodaj nowy produkt")
                        Spacer()
                    }
                }
                .buttonStyle(PlainButtonStyle())

            }.navigationBarTitle("My Products")
                .navigationBarItems(trailing: Button(action: {
                    viewModel.logout(with: authService)
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Log Out")
                })
        }.onAppear {
            print("onAppear")
            viewModel.loadProducts(with: authService)
        }
    }
}

#Preview {
    MyProductsView()
}
