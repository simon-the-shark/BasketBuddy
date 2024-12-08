//
//  ShoppingListDetailViewModel.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import Foundation

extension ShoppingListDetailView {
    class ViewModel: ObservableObject {
        lazy var objectId: Int = {
            fatalError("objectId has not been initialized")
        }()

        @Published var shoppingListDetail: ShoppingListDetail? = nil
        var isLoading: Bool {
            return shoppingListDetail == nil
        }

        var items: [ShoppingListItem] {
            return shoppingListDetail?.items ?? []
        }

        @Published var isSheetShown = false

        private let repository = ShoppingListDetailRepository.shared

        func loadObject(with: AuthService, id: Int) {
            objectId = id
            Task {
                let detailData = await repository.getById(id: id, with: with)
                DispatchQueue.main.async {
                    self.shoppingListDetail = detailData
                }
            }
        }

        func showProductSheet() {
            isSheetShown = true
        }

        func addProduct(with: AuthService, prod: Product) {
            Task {
                let success = await repository.addProduct(with: with, listId: objectId, product: prod)
                if success {
                    loadObject(with: with, id: objectId)
                }
            }
        }
    }
}
