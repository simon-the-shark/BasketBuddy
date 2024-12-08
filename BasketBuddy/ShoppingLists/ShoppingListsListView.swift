//
//  ShoppingListsListView.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 06/12/2024.
//

import SwiftUI

struct ShoppingListsListView: View {
    @StateObject var viewModel: ViewModel = .init()

    var body: some View {
        NavigationView {
            LogoAppBar {
                List {
                    Section {
                        ForEach($viewModel.shoppingLists) { $item in
                            NavigationLink {
                                Text("Item at ")
                            } label: {
                                Button {
                                    // Add your edit action here
                                } label: {
                                    Label("Favourite", systemImage: "star")
                                        .labelStyle(IconOnlyLabelStyle())
                                        .font(.system(size: 16))
                                }

                                Text("Item at \(item.name)")
                                    .font(.body)
                                    .padding(8.0)
                            }
                            .swipeActions {
                                Button {
                                    // Add your edit action here
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.orange)
                                Button(role: .destructive) {
                                    // Add your delete action here
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    } header: {
                        Text("Aktywne listy zakupów").padding(.top, 0)
                    }
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text("Dodaj listę")
                        }
                        Spacer()
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("GrayBackground"))
            }
        }
    }
}

#Preview {
    ShoppingListsListView()
}
