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
                var historicalLists = newData.filter { !$0.isActive } // ! changed here
                historicalLists.sort(by: { $0.id < $1.id })
                DispatchQueue.main.async {
                    self.shoppingLists = historicalLists
                    self.isLoading = false
                }
            }
        }
    }
}
