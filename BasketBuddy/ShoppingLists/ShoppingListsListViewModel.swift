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
        
        init() {
            fetchShoppingLists()
        }
        
        func fetchShoppingLists() {
            Task {
                shoppingLists = await ShoppingListsRepository.shared.fetchShoppingLists()
            }
        }

        func addShoppingList(_ shoppingList: ShoppingList) {
            shoppingLists.append(shoppingList)
        }

        func removeShoppingList(at index: Int) {
            shoppingLists.remove(at: index)
        }
    }
}
