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

    var body: some View {
        HStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                List {
                    ForEach(viewModel.items) {
                        item in
                        ShoppingItemTile(item: item, viewModel: viewModel)
                    }
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
            }
        }
        .navigationTitle(viewModel.shoppingListDetail?.name ?? "")
        .toolbarTitleDisplayMode(.large)
        .scrollContentBackground(.hidden)
        .background(Color("GrayBackground"))
        .onAppear {
            viewModel.loadObject(with: authService, id: objectId)
        }.sheet(isPresented: $viewModel.isSheetShown) {
            ProductsView { product in
                viewModel.addProduct(with: authService, prod: product)
            }
        }
    }
}

#Preview {
    ShoppingListsListView().environmentObject(AuthService())
}
