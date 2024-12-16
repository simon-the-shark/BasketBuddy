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
            LogoAppBar {
                EditNameDialog(viewModel: viewModel) {
                    List {
                        Section {
                            ForEach($viewModel.shoppingLists) { $item in
                                ShoppingListTile(item: item, mode: ShoppingListTile.TileMode.active, viewModel: viewModel)
                            }
                        }
                        header: {
                            Text("Aktywne listy zakupów").padding(.top, 0)
                        }
                        HStack {
                            Spacer()
                            Button {
                                viewModel.showAddListDialog()
                            } label: {
                                Text("Dodaj listę")
                            }
                            Spacer()
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("GrayBackground"))
                }
            } action: {
                viewModel.showAddListDialog()
            }

            .onAppear {
                viewModel.fetchShoppingLists(with: authService)
            }
            .navigationTitle("BasketBuddy")
        }
    }
}

#Preview {
    ShoppingListsListView().environmentObject(AuthService())
}
