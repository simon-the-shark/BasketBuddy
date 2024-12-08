//
//  ShoppingListsListViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 07/12/2024.
//

import Foundation

extension ShoppingListsListView {
    class ViewModel: ObservableObject {
        @Published var shoppingLists: [ShoppingList] = []

        func fetchShoppingLists(with: AuthService) {
            Task {
                shoppingLists = await ShoppingListsRepository.shared.fetchShoppingLists(with: with)
            }
        }

        func removeShoppingList(at index: Int, with: AuthService) {
            let item = shoppingLists.remove(at: index)
            Task {
                let success = await ShoppingListsRepository.shared.removeList(with: with, item: item)
                if !success {
                    shoppingLists.append(item)
                }
            }
        }
    }
}
