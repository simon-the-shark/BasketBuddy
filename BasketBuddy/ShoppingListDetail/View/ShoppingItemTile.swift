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
            VStack(alignment: .leading) {
                Text(item.product.name)
                    .font(.headline)
                Text("\(quantity) \(item.unit)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Stepper(value: $quantity, in: 0 ... 100) {
                Text("")
            }

        }.onAppear {
            self.quantity = item.quantity
        }.onChange(of: quantity) {
            self.viewModel.changeQuantity(with: authService, item: item, newQuantity: self.quantity)
        }
    }
}
