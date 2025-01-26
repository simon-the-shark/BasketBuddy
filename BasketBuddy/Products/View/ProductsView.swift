//
//  ProductsView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var viewModel: ViewModel = .init()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authService: AuthService
    var action: (_ product: Product) -> Void

    init(action: @escaping (_ product: Product) -> Void) {
        self.action = action
    }

    var body: some View {
        VStack {
            if viewModel.products.isEmpty {
                ProgressView("Loading ...")
            } else {
                RoundedRectangle(cornerRadius: 3.0)
                    .frame(width: 60, height: 6)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.top, 8)
                Text("Dodaj produkt do listy")
                    .font(.headline)
                    .padding()
                List {
                    ForEach(Array(viewModel.groupProductsByCategory.keys), id: \.id) { category in
                        Section(header: Text(category.name)) {
                            ForEach(viewModel.groupProductsByCategory[category] ?? []) {
                                product in
                                Button {
                                    action(product)
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    HStack {
                                        CategoryIcon(category: product.category, isEnabled: true, frameDimension: 50)
                                            .padding(.trailing)
                                        Text(product.name)
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                        }
                    }

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.loadProducts(with: authService)
        }
    }
}

#Preview {
    ProductsView { _ in }.environmentObject(AuthService())
}
