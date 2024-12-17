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

        @Published var dialogInputText = ""
        @Published var listUnderEditing: ShoppingList? = nil
        @Published var isPresented: Bool = false
        @Published var isLoading: Bool = true

        var isDialogInEditingMode: Bool {
            return listUnderEditing != nil
        }

        func fetchShoppingLists(with: AuthService) {
            Task {
                let newData = await ShoppingListsRepository.shared.fetchShoppingLists(with: with)
                let activeLists = newData.filter { $0.isActive }
                DispatchQueue.main.async {
                    self.shoppingLists = activeLists
                    self.isLoading = false
                }
            }
        }

        func removeShoppingList(item: ShoppingList, with: AuthService) {
            Task {
                let success = await ShoppingListsRepository.shared.removeList(with: with, item: item)
                if success {
                    fetchShoppingLists(with: with)
                }
            }
        }

        func deactivateShoppingList(item: ShoppingList, with: AuthService) {
            Task {
                let newItem = ShoppingList(id: item.id, name: item.name, color: item.color, emoji: item.emoji, isActive: false, owner: item.owner)
                let success = await ShoppingListsRepository.shared.editList(with: with, item: newItem)
                if success {
                    fetchShoppingLists(with: with)
                }
            }
        }

        func cancelDialog() {
            isPresented = false
            listUnderEditing = nil
            dialogInputText = ""
        }

        func saveDialog(with: AuthService) {
            isPresented = false
            if isDialogInEditingMode {
                var item = listUnderEditing!
                item.name = dialogInputText
                Task {
                    let success = await ShoppingListsRepository.shared.editList(with: with, item: item)
                    if success {
                        fetchShoppingLists(with: with)
                        onEditingDialogDoneCallback?()
                        onEditingDialogDoneCallback = nil
                    }
                }
            } else {
                let item = ShoppingListTemplate(name: dialogInputText, color: "default", emoji: "s", isActive: true)
                Task {
                    let success = await ShoppingListsRepository.shared.addList(with: with, item: item)
                    if success {
                        fetchShoppingLists(with: with)
                    }
                }
            }
            listUnderEditing = nil
            dialogInputText = ""
        }

        func showAddListDialog() {
            listUnderEditing = nil
            isPresented = true
        }

        private var onEditingDialogDoneCallback: (() -> Void)? = nil

        func showEditListDialog(item: ShoppingList, onDoneCallback: (() -> Void)? = nil) {
            dialogInputText = item.name
            listUnderEditing = item
            isPresented = true
            onEditingDialogDoneCallback = onDoneCallback
        }
    }
}
