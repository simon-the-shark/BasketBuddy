//
//  ProductsViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

extension ProductsView {
    class ViewModel: ObservableObject {
        private let repository = ProductsRepository.shared
        @Published var products: [Product] = []

        func loadProducts(with: AuthService) {
            Task {
                let products = await repository.getAll(with: with)
                DispatchQueue.main.async {
                    self.products = products
                }
            }
        }
    }
}
