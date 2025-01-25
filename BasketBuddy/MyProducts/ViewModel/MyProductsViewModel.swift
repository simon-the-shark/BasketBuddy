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
        @Published var products: [MyProduct] = []

        var groupProductsByCategory: [Product.Category: [MyProduct]] {
            return Dictionary(grouping: products, by: { $0.category })
        }

        func loadProducts(with: AuthService) {
            Task {
                let products = await repository.getAll(with: with)
                DispatchQueue.main.async {
                    self.products = products
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
