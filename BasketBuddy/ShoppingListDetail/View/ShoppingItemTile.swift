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

    var disabled: Bool = false

    var body: some View {
        HStack {
            if disabled || item.isBought {
                Button {
                    if !disabled {
                        self.viewModel.changeIsBought(with: authService, item: item, isBought: false)
                    }
                } label: {
                    Label("Odznacz jako zakupione", systemImage: "checkmark.square.fill")
                        .labelStyle(IconOnlyLabelStyle())
                        .font(.system(size: 20)).padding(.trailing)
                }
            }
            CategoryIcon(category: item.product.category, isEnabled: !item.isBought && !disabled)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(item.product.name)
                    .font(.subheadline)
                    .foregroundColor(item.isBought || disabled ? .gray : .primary)
                Text("\(quantity) \(item.unit.polishTranslation)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if !item.isBought && !disabled {
                Stepper(value: $quantity, in: 0 ... 100) {
                    Text("")
                }
            }

        }.swipeActions(edge: .leading) {
            if !item.isBought && !disabled {
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
