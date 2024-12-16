//
//  HistoryViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import Foundation


extension HistoryView {
    class ViewModel: ObservableObject {
        private let repository = ShoppingListsRepository.shared
        @Published var historicalLists: [ShoppingList] = []
        @Published var isLoading = true
        
        func fetchHistoricalLists(with: AuthService) {
            Task {
                let newData = await ShoppingListsRepository.shared.fetchShoppingLists(with: with)
                let historicalLists = newData.filter { !$0.isActive }
                DispatchQueue.main.async {
                    self.historicalLists = historicalLists
                    self.isLoading = false
                }
            }
        }

        
    }
}
