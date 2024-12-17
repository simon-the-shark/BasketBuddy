//
//  ShoppingListsListView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 06/12/2024.
//

import SwiftUI

struct ShoppingListsListView: View {
    @StateObject var viewModel: ViewModel = .init()
    @EnvironmentObject private var authService: AuthService

    @FetchRequest(sortDescriptors: [], animation: .default)
    private var favourites: FetchedResults<FavouriteShoppingList>

    func isFav(id: Int) -> Bool {
        return favourites.map { $0.id }.contains(Int64(id))
    }

    var body: some View {
        NavigationView {
            LoadingOverlay(isLoading: viewModel.isLoading) {
                EditNameDialog(viewModel: viewModel) {
                    VStack {
                        List {
                            if viewModel.shoppingLists.isEmpty && !viewModel.isLoading {
                                NoListsInfo()

                            } else {
                                Section {
                                    ForEach($viewModel.shoppingLists.sorted { isFav(id: $0.id) && !isFav(id: $1.id) }) { $item in
                                        ShoppingListTile(item: item, mode: ShoppingListTile.TileMode.active, isFavourite: isFav(id: item.id), viewModel: viewModel)
                                    }
                                }
                                header: {
                                    Text("Aktywne listy zakupów").padding(.top, 0)
                                }
                            }

                            AddListButton(viewModel: viewModel)
                        }

                        .scrollContentBackground(.hidden)
                        .background(Color("GrayBackground"))

                    }.toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                viewModel.showAddListDialog()
                            } label: {
                                Label("Dodaj listę", systemImage: "plus.app")
                            }.controlSize(.extraLarge).padding(.top, 20)
                        }
                    }
                    .onAppear {
                        viewModel.fetchShoppingLists(with: authService)
                    }
                    .navigationTitle("BasketBuddy")
                }
            }
        }
    }
}
