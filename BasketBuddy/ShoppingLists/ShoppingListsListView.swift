//
//  ShoppingListsListView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 06/12/2024.
//

import SwiftUI

struct ShoppingListsListView: View {
    @StateObject var viewModel: ViewModel = ViewModel()

    var body: some View {
        NavigationView {
            LogoAppBar {
                List {
                    ForEach($viewModel.shoppingLists) { $item in
                        NavigationLink {
                            Text("Item at ")
                        } label: {
                            Text("Item at \(item.name)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ShoppingListsListView()
}
