//
//  ShoppingItemTile.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 10/12/2024.
//

import SwiftUI

struct ShoppingItemTile: View {
    var item: ShoppingListItem
    @ObservedObject var viewModel: ShoppingListDetailView.ViewModel
    @EnvironmentObject var authService: AuthService
    @State var quantity: Int = 0

    var body: some View {
        HStack {
            if item.isBought {
                Button {
                    self.viewModel.changeIsBought(with: authService, item: item, isBought: false)
                } label: {
                    Label("Odznacz jako zakupione", systemImage: "checkmark.square.fill")
                        .labelStyle(IconOnlyLabelStyle())
                        .font(.system(size: 20)).padding(.trailing)
                }
            }
            VStack(alignment: .leading) {
                Text(item.product.name)
                    .font(.headline)
                    .foregroundColor(item.isBought ? .gray : .primary)
                Text("\(quantity) \(item.unit)")
                    .font(.subheadline)
                    .foregroundColor(item.isBought ? .gray : .primary)
            }
            Spacer()
            if !item.isBought {
                Stepper(value: $quantity, in: 0 ... 100) {
                    Text("")
                }
            }

        }.swipeActions(edge: .leading) {
            if !item.isBought {
                Button(action: {
                    self.viewModel.changeIsBought(with: authService, item: item, isBought: true)
                }) {
                    Label("Oznacz jako zakupione", systemImage: "checkmark.square")
                }
                .tint(.green)
            }
        }
        .onAppear {
            self.quantity = item.quantity
        }.onChange(of: quantity) {
            self.viewModel.changeQuantity(with: authService, item: item, newQuantity: self.quantity)
        }
    }
}
