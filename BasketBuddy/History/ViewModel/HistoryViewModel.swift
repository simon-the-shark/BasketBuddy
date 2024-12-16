//
//  HistoryViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import Foundation

extension HistoryView {
    class ViewModel: ShoppingListsListView.ViewModel {
        override func fetchShoppingLists(with: AuthService) {
            Task {
                let newData = await ShoppingListsRepository.shared.fetchShoppingLists(with: with)
                let historicalLists = newData.filter { !$0.isActive } // ! changed here
                DispatchQueue.main.async {
                    self.shoppingLists = historicalLists
                    self.isLoading = false
                }
            }
        }
    }
}
