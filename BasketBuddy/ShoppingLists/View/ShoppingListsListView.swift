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
                List {
                    Section {
                        ForEach($viewModel.shoppingLists) { $item in
                            ShoppingListTile(item: item, viewModel: viewModel)
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
                .alert((viewModel.isDialogInEditingMode) ? "Edytuj nazwę listy" : "Dodajesz nową listę", isPresented: $viewModel.isPresented) {
                    TextField("Nazwa listy", text: $viewModel.dialogInputText)

                    Button("Anuluj", role: .cancel, action: viewModel.cancelDialog)

                    Button(viewModel.isDialogInEditingMode ? "Zapisz" : "Dodaj", action: viewModel.saveDialog)

                } message: {
                    Text(viewModel.isDialogInEditingMode ? "Edytujesz listę \(viewModel.listUnderEditing!.name)" : "Wpisz nazwę nowej listy")
                }
            }.onAppear {
                viewModel.fetchShoppingLists(with: authService)
            }
        }
    }
}

#Preview {
    ShoppingListsListView().environmentObject(AuthService())
}
