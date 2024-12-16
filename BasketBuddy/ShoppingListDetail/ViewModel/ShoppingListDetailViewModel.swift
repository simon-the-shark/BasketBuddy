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

        var boughtItems: [ShoppingListItem] {
            return items.filter {
                item in item.isBought
            }
        }

        var notBoughtItems: [ShoppingListItem] {
            return items.filter {
                item in !item.isBought
            }
        }

        var itemsGroupedByCategory: [Product.Category: [ShoppingListItem]] {
            return Dictionary(grouping: notBoughtItems, by: { $0.product.category })
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

        func changeQuantity(with: AuthService, item: ShoppingListItem, newQuantity: Int) {
            Task {
                let template = ShoppingListItemTemplate(product_id: item.product.id, quantity: newQuantity, unit: item.unit, isBought: item.isBought)
                let _ = await repository.updateItem(with: with, listId: objectId, itemId: item.id, newItem: template)
            }
        }

        func changeIsBought(with: AuthService, item: ShoppingListItem, isBought: Bool) {
            Task {
                let template = ShoppingListItemTemplate(product_id: item.product.id, quantity: item.quantity, unit: item.unit, isBought: isBought)
                let success = await repository.updateItem(with: with, listId: objectId, itemId: item.id, newItem: template)
                if success {
                    self.loadObject(with: with, id: objectId)
                }
            }
        }

        func activateThisListAgain(with: AuthService, onDone: @escaping () -> Void) {
            guard let curr = shoppingListDetail else {
                return
            }
            Task {
                let newData = ShoppingList(id: curr.id, name: curr.name, color: curr.color, emoji: curr.emoji, isActive: true, owner: curr.owner)
                let _ = await ShoppingListsRepository.shared.editList(with: with, item: newData)
                DispatchQueue.main.async {
                    onDone()
                }
            }
        }
    }
}
