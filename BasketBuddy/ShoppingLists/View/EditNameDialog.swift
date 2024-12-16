//
//  EditNameDialog.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 16/12/2024.
//

import SwiftUI

struct EditNameDialog<Content: View>: View {
    var content: Content
    @ObservedObject var viewModel: ShoppingListsListView.ViewModel
    @EnvironmentObject var authService: AuthService

    init(viewModel: ShoppingListsListView.ViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.viewModel = viewModel
    }

    var body: some View {
        content
            .alert((viewModel.isDialogInEditingMode) ? "Edytuj nazwę listy" : "Dodajesz nową listę", isPresented: $viewModel.isPresented) {
                TextField("Nazwa listy", text: $viewModel.dialogInputText)

                Button("Anuluj", role: .cancel, action: viewModel.cancelDialog)

                Button(viewModel.isDialogInEditingMode ? "Zapisz" : "Dodaj") {
                    viewModel.saveDialog(with: authService)
                }

            } message: {
                Text(viewModel.isDialogInEditingMode ? "Edytujesz listę \(viewModel.listUnderEditing!.name)" : "Wpisz nazwę nowej listy")
            }
    }
}
