//
//  CategoryIcon.swift
//  BasketBuddy
//
//  Created by Szymon Kowaliński on 10/12/2024.
//

import SwiftUI

struct CategoryIcon: View {
    var category: Product.Category
    var isEnabled: Bool
    var frameDimension: CGFloat?
    var body: some View {
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "\(category.id)_product_category.png"))
                .resizable()
                .frame(width: frameDimension == nil ? nil : frameDimension, height: frameDimension == nil ? 200 : frameDimension)
                .opacity(isEnabled ? 1 : 0.5)
        }
    }
}

#Preview {
    CategoryIcon(
        category: Product.Category(id: 6, name: ""),
        isEnabled: true
    )
}
