//
//  ActiveListContents.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import SwiftUI

struct GroupedByCategoryList: View {
    @ObservedObject var viewModel: ShoppingListDetailView.ViewModel
    var body: some View {
        ForEach(Array(viewModel.itemsGroupedByCategory.keys.sorted(by: { a, b in
            a.id > b.id
        })), id: \.id) { category in
            Section(header: Text(category.name)) {
                ForEach(viewModel.itemsGroupedByCategory[category] ?? [], id: \.id) {
                    item in
                    ShoppingItemTile(item: item, viewModel: viewModel)
                }
            }
        }
    }
}

struct ActiveListContents: View {
    @ObservedObject var viewModel: ShoppingListDetailView.ViewModel
    var body: some View {
        GroupedByCategoryList(viewModel: viewModel)
        if !viewModel.isLoading {
            HStack {
                Spacer()
                Button {
                    viewModel.showProductSheet()
                } label: {
                    Text("Dodaj produkt")
                }
                Spacer()
            }
        }

        if !viewModel.boughtItems.isEmpty {
            Section {
                ForEach(viewModel.boughtItems, id: \.id) {
                    item in
                    ShoppingItemTile(item: item, viewModel: viewModel)
                }
            } header: {
                Text("Zakupione")
            }
        }
    }
}
