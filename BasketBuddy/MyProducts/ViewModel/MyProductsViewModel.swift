//
//  MyProductsViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import Foundation

//
//  HistoryViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import Foundation

extension MyProductsView {
    class ViewModel: ObservableObject {
        private let repository = MyProductsRepository.shared
        private let categoriesRepo = CategoriesRepository.shared
        @Published var products: [MyProduct] = []
        @Published var categories: [Product.Category] = []

        var groupProductsByCategory: [Product.Category: [MyProduct]] {
            return Dictionary(grouping: products, by: { $0.category }).mapValues { $0.sorted(by: { $0.id < $1.id }) }
        }

        func loadProducts(with: AuthService) {
            Task {
                let products = await repository.getAll(with: with)
                let categories = await categoriesRepo.getAll(with: with)
                DispatchQueue.main.async {
                    self.products = products.sorted(by: { $0.id < $1.id })
                    self.categories = categories.sorted(by: { $0.id < $1.id })
                }
            }
        }

        func logout(with: AuthService) {
            do {
                try with.logout()
            } catch {
                // ignore
                print(error)
            }
        }
    }
}
