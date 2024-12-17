//
//  AddListButton.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 17/12/2024.
//

import SwiftUI

struct AddListButton: View {
    @ObservedObject var viewModel: ShoppingListsListView.ViewModel
    var body: some View {
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
}
