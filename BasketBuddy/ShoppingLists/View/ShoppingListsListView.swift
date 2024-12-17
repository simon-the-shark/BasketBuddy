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
                                    ForEach($viewModel.shoppingLists) { $item in
                                        ShoppingListTile(item: item, mode: ShoppingListTile.TileMode.active, viewModel: viewModel)
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
