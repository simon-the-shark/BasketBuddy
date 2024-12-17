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
            List {
                if isListActive {
                    ActiveListContents(viewModel: viewModel)
                } else {
                    InactiveListContents(viewModel: viewModel)
                }
            }
        }.onAppear {
            viewModel.loadObject(with: authService, id: objectId)
        }.navigationTitle(viewModel.shoppingListDetail?.name ?? "")
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
