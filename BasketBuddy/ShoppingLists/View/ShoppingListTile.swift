//
//  ShoppingListTile.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import SwiftUI

struct ShoppingListTile: View {
    enum TileMode {
        case active, historical
    }

    var item: ShoppingList
    var mode: TileMode
    var isFavourite: Bool
    @ObservedObject var viewModel: ShoppingListsListView.ViewModel
    @EnvironmentObject var authService: AuthService

    var body: some View {
        HStack {
            if mode == TileMode.active {
                FavouriteButton(isFavourite: isFavourite, itemId: item.id)
            }
            NavigationLink {
                ShoppingListDetailView(objectId: item.id, isListActive: mode == TileMode.active)
            } label: {
                if mode == TileMode.historical {
                    Label("Historyczna lista", systemImage: "text.book.closed")
                        .labelStyle(IconOnlyLabelStyle())
                }
                Text(item.name)
                    .font(.body)
                    .padding(8.0)
            }
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
                    if mode == TileMode.historical {
                        viewModel.removeShoppingList(item: item, with: authService)
                    } else {
                        viewModel.deactivateShoppingList(item: item, with: authService)
                    }
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
