//
//  ShoppingListDetailView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 08/12/2024.
//

import SwiftUI

struct ShoppingListDetailView: View {
    @StateObject var viewModel: ViewModel = .init()

    @EnvironmentObject private var authService: AuthService
    var objectId: Int
    var isListActive: Bool

    var body: some View {
        LoadingOverlay(isLoading: viewModel.isLoading) {
            EditNameDialog(viewModel: viewModel.parentViewModel) {
                List {
                    if isListActive {
                        ActiveListContents(viewModel: viewModel)
                    } else {
                        InactiveListContents(viewModel: viewModel)
                    }
                }
            }
        }.onAppear {
            viewModel.loadObject(with: authService, id: objectId)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.changeListName(
                        with: authService
                    )
                } label: {
                    Label("Edytuj nazwę listy", systemImage: "pencil")
                }.controlSize(.extraLarge)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {} label: {
                    Label("Dodaj produkt do listy", systemImage: "plus.app")
                }.controlSize(.extraLarge)
            }
        }

        .navigationTitle(viewModel.shoppingListDetail?.name ?? "")
        .toolbarTitleDisplayMode(.large)
        .scrollContentBackground(.hidden)
        .background(Color("GrayBackground"))
        .sheet(isPresented: $viewModel.isSheetShown) {
            ProductsView { product in
                viewModel.addProduct(with: authService, prod: product)
            }
        }
    }
}

#Preview {
    ShoppingListsListView().environmentObject(AuthService())
}
