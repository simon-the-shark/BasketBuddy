//
//  MyProductTile.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 25/01/2025.
//

import SwiftUI

struct MyProductTile: View {
    var product: MyProduct
    var categories: [Product.Category]
    var body: some View {
        NavigationLink {
            MyProductsFormView(product: product, categories: categories)
        } label: {
            if(product.image == nil){
                CategoryIcon(category: product.category, isEnabled: true)
                    .padding(.trailing)
            }
            if(product.image != nil){
                AsyncImage(url: URL(string: product.image!)) { image in
                    image.resizable()                    .frame(width: 50, height: 50)

                } placeholder: {
                    ProgressView()
                }
                            }
            Text(product.name)
                .font(.subheadline)
                .foregroundColor(.primary)
        }

    }
}

