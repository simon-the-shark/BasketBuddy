//
//  ShoppingListTile.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import SwiftUI

struct ShoppingListTile: View {
    var item: ShoppingList
    @ObservedObject var viewModel: ShoppingListsListView.ViewModel
    @EnvironmentObject var authService: AuthService

    var body: some View {
        NavigationLink {
            Text("Item at ")
        } label: {
            Button {
                // Add your edit action here
            } label: {
                Label("Nie jest ulubiony", systemImage: "star")
                    .labelStyle(IconOnlyLabelStyle())
                    .font(.system(size: 16))
            }

            Text(item.name)
                .font(.body)
                .padding(8.0)
        }
        .swipeActions {
            Button {
                viewModel.showEditListDialog(item: item)
            } label: {
                Label("Edytuj", systemImage: "pencil")
            }
            .tint(.orange)
            Button(role: .destructive) {
                withAnimation {
                    viewModel.removeShoppingList(item: item, with: authService)
                }
            } label: {
                Label("Usuń", systemImage: "trash")
            }
        }
    }
}

#Preview {
    ShoppingListsListView().environmentObject(AuthService())
}
