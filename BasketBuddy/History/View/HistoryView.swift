//
//  HistoryView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: ViewModel = .init()
    @EnvironmentObject private var authService: AuthService

    var body: some View {
        NavigationView {
            LoadingOverlay(isLoading: viewModel.isLoading) {
                EditNameDialog(viewModel: viewModel) {
                    List {
                        if viewModel.shoppingLists.isEmpty && !viewModel.isLoading {
                            NoListsInfo()
                        } else if !viewModel.shoppingLists.isEmpty {
                            Section {
                                ForEach($viewModel.shoppingLists, id: \.id) { $item in
                                    ShoppingListTile(item: item, mode: ShoppingListTile.TileMode.historical, isFavourite: false, viewModel: viewModel)
                                }
                            }
                            header: {
                                Text("Historyczne listy zakupów").padding(.top, 0)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("GrayBackground"))
                }

                .onAppear {
                    viewModel.fetchShoppingLists(with: authService)
                }
                .navigationTitle("Historia Zakupów")
            }
        }
    }
}

#Preview {
    HistoryView()
}
