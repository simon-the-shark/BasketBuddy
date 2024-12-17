//
//  InactiveListContents.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import SwiftUI

struct InactiveListContents: View {
    @ObservedObject var viewModel: ShoppingListDetailView.ViewModel
    @EnvironmentObject var authService: AuthService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        if !viewModel.items.isEmpty {
            Section {
                ForEach(viewModel.items, id: \.id) {
                    item in
                    ShoppingItemTile(item: item, viewModel: viewModel, disabled: true)
                }
            } header: {
                Text("Zakupione")
            }
        }

        if !viewModel.isLoading {
            HStack {
                Spacer()
                Button {
                    viewModel.activateThisListAgain(with: authService) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Ponownie wykorzystaj tą listę")
                }
                Spacer()
            }
        }
    }
}
