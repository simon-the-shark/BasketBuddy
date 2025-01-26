//
//  NameInput.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 26/01/2025.
//

import SwiftUI

struct NameInput: View {
    @ObservedObject var viewModel: MyProductsFormView.ViewModel
    @State private var productName: String
    init(viewModel: MyProductsFormView.ViewModel) {
        productName = viewModel.productName
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Text("Nazwa").padding(.trailing)
            TextField("Nazwa", text: $productName)
        }.onChange(of: productName) { _, _ in
            viewModel.productName = productName
        }
    }
}
